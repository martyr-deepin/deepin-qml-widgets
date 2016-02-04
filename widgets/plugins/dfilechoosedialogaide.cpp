/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

#include "dfilechoosedialogaide.h"

DFileChooseDialogAide::DFileChooseDialogAide(QObject *parent) :
    QObject(parent)
{
    initThumbnailConfig();
}

DFileChooseDialogAide::~DFileChooseDialogAide()
{

}


QString DFileChooseDialogAide::getLargeThumbnailPath(QString fileName)
{
    return getThumbnailPath(fileName,DFileChooseDialogAide::LargeThumbnail);
}

QString DFileChooseDialogAide::getNormalThumbnailPath(QString fileName)
{
    return getThumbnailPath(fileName, DFileChooseDialogAide::NormalThumbnail);
}

QString DFileChooseDialogAide::getIconName(QString fileName)
{
    QFile tmpFile(fileName);
    if (!tmpFile.exists())
        return "";

    QMimeDatabase mimeDB;
    QMimeType mime = mimeDB.mimeTypeForFile(fileName);
    return mime.iconName();
}

bool DFileChooseDialogAide::removeThumbnail(QString fileName)
{
    QFile::remove(getLargeThumbnailPath(fileName));
    QFile::remove(getNormalThumbnailPath(fileName));

    QFile configFile(DFCD_THUMBNAIL_CONFIG_FILE);
    if (!configFile.open(QIODevice::ReadOnly))
        return false;

    QJsonParseError error;
    QJsonDocument thumbnailDoc = QJsonDocument::fromJson(configFile.readAll(),&error);
    configFile.close();
    if (!error.error == QJsonParseError::NoError)
    {
        qDebug() << error.errorString();
        return false;
    }

    if (thumbnailDoc.isObject())
    {
        QJsonObject tmpObj = thumbnailDoc.object();
        tmpObj.remove(fileName);
        thumbnailDoc.setObject(tmpObj);

        if (!configFile.open(QIODevice::WriteOnly))
            return false;

        configFile.write(thumbnailDoc.toJson());
        configFile.close();


        return true;
    }
    else
    {
        return false;
    }
}

bool DFileChooseDialogAide::isImage(QString fileName)
{
    QFile tmpFile(fileName);
    if (!tmpFile.exists())
        return false;

    QMimeDatabase mimeDB;
    QMimeType mime = mimeDB.mimeTypeForFile(fileName);
    if (mime.name().contains("image/"))
        return true;
    else
        return false;
}

bool DFileChooseDialogAide::fileExist(QString fileName)
{
    return QFile::exists(fileName);
}

bool DFileChooseDialogAide::fileIsDir(QString fileName)
{
    QFileInfo checkInfo(fileName);
    return checkInfo.isDir();
}

void DFileChooseDialogAide::initThumbnailConfig()
{
    QDir localConfigDir;
    //如果路径不存在,则先新建文件夹,通常只会执行一次,即程序初次运行
    if (!localConfigDir.exists(THUMBNAIL_SAVE_PATH_LARGE))
        localConfigDir.mkpath(THUMBNAIL_SAVE_PATH_LARGE);

    if (!localConfigDir.exists(THUMBNAIL_SAVE_PATH_NARMAL))
        localConfigDir.mkpath(THUMBNAIL_SAVE_PATH_NARMAL);

    QFile configFile(DFCD_THUMBNAIL_CONFIG_FILE);
    if (!configFile.exists())
    {
        if (!configFile.open(QIODevice::WriteOnly | QIODevice::Truncate))
        {
            return;
        }
        else
        {
            configFile.close();
        }
    }
}

QString DFileChooseDialogAide::getThumbnailPath(QString fileName, ThumbnailSize sizeValue)
{
    initThumbnailConfig();
    QFile configFile(DFCD_THUMBNAIL_CONFIG_FILE);
    if (!configFile.open(QIODevice::ReadOnly))
        return "";

    QByteArray thumbnailData = configFile.readAll();
    if (thumbnailData.isEmpty())
    {
        //go generate thumbnail
        if (addThumbnail(fileName))
            return getThumbnailPath(fileName, sizeValue);
        else
            return "";
    }
    QJsonParseError error;
    QJsonDocument thumbnailDoc = QJsonDocument::fromJson(thumbnailData,&error);
    configFile.close();
    if (!error.error == QJsonParseError::NoError)
    {
        qDebug() << error.errorString();
        return "";
    }

    if (thumbnailDoc.isObject())
    {
        QJsonObject tmpObj = thumbnailDoc.object();
        if (tmpObj.value(fileName).isUndefined())
        {
            //go generate thumbnail
            if (addThumbnail(fileName))
                return getThumbnailPath(fileName, sizeValue);
            else
                return "";
        }
        else
        {
            switch (sizeValue)
            {
            case DFileChooseDialogAide::LargeThumbnail:
                return tmpObj.value(fileName).toObject().value("large").toString("");
                break;
            case DFileChooseDialogAide::NormalThumbnail:
                return tmpObj.value(fileName).toObject().value("normal").toString("");
                break;
            default:
                return "";
                break;
            }

        }
    }
    else
    {
        return "";
    }
}


bool DFileChooseDialogAide::addThumbnail(QString fileName)
{
    QString largePath = generateLargeThumbnail(fileName);
    QString normalPath = generateNormalThumbnail(fileName);

    if (largePath != "" && normalPath != "")
        return insertThumbnailInfo(fileName, largePath, normalPath);
    else
        return false;
}

bool DFileChooseDialogAide::insertThumbnailInfo(QString fileName, QString largePath, QString normalPath)
{
    QFile configFile(DFCD_THUMBNAIL_CONFIG_FILE);
    if (!configFile.open(QIODevice::ReadOnly))
        return false;

    QJsonParseError error;
    QByteArray thumbnailDate = configFile.readAll();
    QJsonDocument thumbnailDoc;
    if (!thumbnailDate.isEmpty())
    {
        thumbnailDoc = QJsonDocument::fromJson(thumbnailDate,&error);
    }
    configFile.close();

    if (!error.error == QJsonParseError::NoError && error.errorString() != "")
    {
        qDebug()<<"QJsonParseError:" << error.errorString();
        return false;
    }

    if (thumbnailDoc.isObject() || thumbnailDate.isEmpty())
    {
        QJsonObject tmpObj = thumbnailDoc.object();
        QJsonObject subObj;
        subObj.insert("large", QJsonValue(largePath));
        subObj.insert("normal", QJsonValue(normalPath));
        tmpObj.insert(fileName,QJsonValue(subObj));
        thumbnailDoc.setObject(tmpObj);

        if (!configFile.open(QIODevice::WriteOnly))
            return false;

        configFile.write(thumbnailDoc.toJson());
        configFile.close();

        return true;
    }
    else
    {
        return false;
    }
}

QString DFileChooseDialogAide::generateLargeThumbnail(QString fileName)
{
    if(isImage(fileName))
    {
        QUuid tmpUuid;
        QString tmpName = tmpUuid.createUuid().toString().remove(QRegularExpression("[-{}]")) + ".png";
        QImage sourceImg(fileName);
        if (sourceImg.isNull())
            return "";

        QImage resultImg = sourceImg.scaled(sourceImg.width(),sourceImg.height()).scaled(
                    sourceImg.width() >= LARGE_WIDTH?LARGE_WIDTH:sourceImg.width(),
                    sourceImg.height() >= LARGE_HEIGHT?LARGE_HEIGHT:sourceImg.height(),
                    Qt::IgnoreAspectRatio, Qt::SmoothTransformation);

        QFile resultFile(THUMBNAIL_SAVE_PATH_LARGE + tmpName);
        if (!resultFile.open(QIODevice::ReadWrite))
        {
            qDebug() << "open result file error";
            return "";
        }

        QByteArray ba;

        QBuffer buffer(&ba);
        buffer.open(QIODevice::WriteOnly);

        resultImg.save(&buffer, "PNG");

        resultFile.write(ba);

        resultFile.close();

        return THUMBNAIL_SAVE_PATH_LARGE + tmpName;
    }

    qDebug() << "not image file";
    return "";
}

QString DFileChooseDialogAide::generateNormalThumbnail(QString fileName)
{
    if(isImage(fileName))
    {
        QUuid tmpUuid;
        QString tmpName = tmpUuid.createUuid().toString().remove(QRegularExpression("[-{}]")) + ".png";
        QImage sourceImg(fileName);
        if (sourceImg.isNull())
            return "";

        QImage resultImg = sourceImg.scaled(sourceImg.width(),sourceImg.height()).scaled(
                    sourceImg.width() >= NORMAL_WIDTH?NORMAL_WIDTH:sourceImg.width(),
                    sourceImg.height() >= NORMAL_HEIGHT?NORMAL_HEIGHT:sourceImg.height(),
                    Qt::IgnoreAspectRatio, Qt::SmoothTransformation);

        QFile resultFile(THUMBNAIL_SAVE_PATH_NARMAL + tmpName);
        if (!resultFile.open(QIODevice::ReadWrite))
        {
            qDebug() << "open result file error";
            return "";
        }

        QByteArray ba;

        QBuffer buffer(&ba);
        buffer.open(QIODevice::WriteOnly);

        resultImg.save(&buffer, "PNG");

        resultFile.write(ba);

        resultFile.close();

        return THUMBNAIL_SAVE_PATH_NARMAL + tmpName;
    }

    qDebug() << "not image file";
    return "";
}


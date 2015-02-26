#ifndef DFILECHOOSEDIALOGAIDE_H
#define DFILECHOOSEDIALOGAIDE_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include <QStandardPaths>
#include <QImage>
#include <QDir>
#include <QUuid>
#include <QBuffer>
#include <QMimeDatabase>
#include <QRegularExpression>
#include <QDebug>

class DFileChooseDialogAide : public QObject
{
    Q_OBJECT
public:
    explicit DFileChooseDialogAide(QObject *parent = 0);
    ~DFileChooseDialogAide();

    Q_INVOKABLE QString getLargeThumbnailPath(QString fileName);
    Q_INVOKABLE QString getNormalThumbnailPath(QString fileName);
    Q_INVOKABLE QString getIconName(QString fileName);
    Q_INVOKABLE bool removeThumbnail(QString fileName);
    Q_INVOKABLE bool isImage(QString fileName);

    Q_INVOKABLE bool fileExist(QString fileName);
    Q_INVOKABLE bool fileIsDir(QString fileName);

private:
    enum ThumbnailSize
    {
        LargeThumbnail,
        NormalThumbnail
    };

    void initThumbnailConfig();
    QString getThumbnailPath(QString fileName, ThumbnailSize sizeValue);
    bool addThumbnail(QString fileName);
    bool insertThumbnailInfo(QString fileName, QString largePath, QString normalPath);
    QString generateLargeThumbnail(QString fileName);
    QString generateNormalThumbnail(QString fileName);

private:
    const int LARGE_WIDTH = 64;
    const int LARGE_HEIGHT = 32;
    const int NORMAL_WIDTH = 35;
    const int NORMAL_HEIGHT = 20;
    const QString THUMBNAIL_SAVE_PATH_NARMAL =
            QStandardPaths::standardLocations(QStandardPaths::HomeLocation).at(0) + "/.cache/thumbnails/normal/";
    const QString THUMBNAIL_SAVE_PATH_LARGE =
            QStandardPaths::standardLocations(QStandardPaths::HomeLocation).at(0) + "/.cache/thumbnails/large/";
    const QString DFCD_THUMBNAIL_CONFIG_FILE =
            QStandardPaths::standardLocations(QStandardPaths::HomeLocation).at(0)  + "/.cache/thumbnails/.DFCDConfigFile.json";

};

#endif // DFILECHOOSEDIALOGAIDE_H

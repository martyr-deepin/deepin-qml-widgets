#include "dwidgetstylecontroller.h"

DWidgetStyleController::DWidgetStyleController(QObject *parent) : QObject(parent)
{
    init();
}

void DWidgetStyleController::init()
{
    //makesure path exist
    QDir configDir;
    if (!configDir.exists(CONFIG_FILE_DIR))
    {
        configDir.mkpath(CONFIG_FILE_DIR);
    }
    //makesure config-file exits
    QFile file(CONFIG_FILE_NARMAL);
    if (!file.exists(CONFIG_FILE_NARMAL))
    {
        file.open(QIODevice::WriteOnly);
        file.close();
    }

    currentWidgetStyle = getWidgetStyleFromJson();

    fileWatcher = new QFileSystemWatcher(this);
    fileWatcher->addPath(CONFIG_FILE_NARMAL);
    connect(fileWatcher, SIGNAL(fileChanged(QString)), this, SLOT(configFileChanged(QString)));
}

void DWidgetStyleController::configFileChanged(const QString &path)
{
    if (path == CONFIG_FILE_NARMAL)
    {
        currentWidgetStyle = getWidgetStyleFromJson();
        emit currentWidgetStyleChanged();
    }
}

DWidgetStyleController::WidgetStype DWidgetStyleController::getCurrentWidgetStyle()
{
    return currentWidgetStyle;
}

void DWidgetStyleController::setCurrentWidgetStyle(WidgetStype style)
{
    currentWidgetStyle = style;
    updateCurrentWidgetStyle(style);
    emit currentWidgetStyleChanged();
}

void DWidgetStyleController::updateCurrentWidgetStyle(WidgetStype style)
{
    QFile file(CONFIG_FILE_NARMAL);
    if (!file.exists(CONFIG_FILE_NARMAL))
    {
        file.open(QIODevice::WriteOnly);
        file.close();
    }

    QJsonObject styleObj;
    styleObj.insert("CurrentWidgetStyle", int(style));

    QJsonDocument jsonDocument;
    jsonDocument.setObject(styleObj);

    if (file.open(QIODevice::WriteOnly | QIODevice::Truncate))
    {
        file.write(jsonDocument.toJson(QJsonDocument::Compact));
        file.close();
    }
    else
        qDebug() << "Open DUI style-config file error!";
}

DWidgetStyleController::WidgetStype DWidgetStyleController::getWidgetStyleFromJson()
{
    QFile file(CONFIG_FILE_NARMAL);
    if (!file.exists(CONFIG_FILE_NARMAL))
    {
        file.open(QIODevice::WriteOnly);
        file.close();
    }

    if (!file.open(QIODevice::ReadOnly))
        return DWidgetStyleController::StyleBlack;

    //if got error,return black style
    QJsonParseError jsonError;
    QJsonDocument parseDoucment = QJsonDocument::fromJson(file.readAll(), &jsonError);

    file.close();

    if(jsonError.error == QJsonParseError::NoError)
    {
        if(parseDoucment.isObject())
        {
            QJsonObject obj = parseDoucment.object();
            if(obj.contains("CurrentWidgetStyle"))
            {
                QJsonValue styleValue = obj.take("CurrentWidgetStyle");
                if(styleValue.isDouble())
                    return DWidgetStyleController::WidgetStype(styleValue.toVariant().toInt());
            }
            return DWidgetStyleController::StyleBlack;
        }
        return DWidgetStyleController::StyleBlack;
    }
    else
        return DWidgetStyleController::StyleBlack;
}

DWidgetStyleController::~DWidgetStyleController()
{

}


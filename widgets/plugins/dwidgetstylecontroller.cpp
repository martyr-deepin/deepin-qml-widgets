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
    QFile file(CONFIG_FILE_NAME);
    if (!file.exists(CONFIG_FILE_NAME))
    {
        updateCurrentWidgetStyle(DEEPIN_WIDGETS_DEFAULT_STYLE);
    }

    currentWidgetStyle = getWidgetStyleFromJson();
    imagesPath = getImagesPath();
    configObject = getConfigFromJson();

    fileWatcher = new QFileSystemWatcher(this);
    fileWatcher->addPath(CONFIG_FILE_NAME);
    fileWatcher->addPath(DEEPIN_WIDGETS_STYLE_PATH);
    connect(fileWatcher, SIGNAL(fileChanged(QString)), this, SLOT(configFileChanged(QString)));
    connect(fileWatcher, SIGNAL(directoryChanged(QString)), this, SLOT(styleDirChanged(QString)));
}

void DWidgetStyleController::configFileChanged(const QString &path)
{
    if (path == CONFIG_FILE_NAME)
    {
        currentWidgetStyle = getWidgetStyleFromJson();
        emit currentWidgetStyleChanged();

        imagesPath = getImagesPath();
        emit imagesPathChanged();

        configObject = getConfigFromJson();
        emit configObjectChanged();
    }
}

void DWidgetStyleController::styleDirChanged(const QString &path)
{
    if (path == DEEPIN_WIDGETS_STYLE_PATH)
    {
        emit styleListChanged();
    }
}

QJsonObject DWidgetStyleController::getConfigObject()
{
    return configObject;
}

QString DWidgetStyleController::getImagesPath()
{
    return getResourceDir() + "/images/";
}

QString DWidgetStyleController::getCurrentWidgetStyle()
{
    return currentWidgetStyle;
}

QStringList DWidgetStyleController::getStyleList()
{
    QDir tmpDir(DEEPIN_WIDGETS_STYLE_PATH);
    QStringList styleDirList;
    QStringList tmpDirList = tmpDir.entryList(QDir::Dirs | QDir::NoDotAndDotDot);
    for (int i = 0; i < tmpDirList.count(); i ++)
    {
        if (QFile::exists(DEEPIN_WIDGETS_STYLE_PATH + tmpDirList.at(i) + "/images")
                && QFile::exists(DEEPIN_WIDGETS_STYLE_PATH + tmpDirList.at(i) + "/style.json"))
        {
            styleDirList.append(tmpDirList.at(i));
        }
    }

    return styleDirList;
}

void DWidgetStyleController::setCurrentWidgetStyle(const QString & style)
{
    if (!isAvailableStyle(style))
        return;

    currentWidgetStyle = style;
    updateCurrentWidgetStyle(style);
    emit currentWidgetStyleChanged();
}

bool DWidgetStyleController::isAvailableStyle(const QString &style)
{
    return getStyleList().indexOf(style) != -1;
}

void DWidgetStyleController::updateCurrentWidgetStyle(const QString & style)
{
    QFile file(CONFIG_FILE_NAME);
    if (!file.exists(CONFIG_FILE_NAME))
    {
        file.open(QIODevice::WriteOnly);
        file.close();
    }

    QJsonObject styleObj;
    styleObj.insert("CurrentWidgetStyle", style);

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

QString DWidgetStyleController::getResourceDir()
{
    return DEEPIN_WIDGETS_STYLE_PATH + currentWidgetStyle;
}

QString DWidgetStyleController::getWidgetStyleFromJson()
{
    QFile file(CONFIG_FILE_NAME);
    if (!file.exists(CONFIG_FILE_NAME))
    {
        file.open(QIODevice::WriteOnly);
        file.close();
    }

    if (!file.open(QIODevice::ReadOnly))
        return DEEPIN_WIDGETS_DEFAULT_STYLE;

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
                if(styleValue.isString())
                    return styleValue.toVariant().toString();
            }
            return DEEPIN_WIDGETS_DEFAULT_STYLE;
        }
        return DEEPIN_WIDGETS_DEFAULT_STYLE;
    }
    else
        return DEEPIN_WIDGETS_DEFAULT_STYLE;
}

QJsonObject DWidgetStyleController::getConfigFromJson()
{
    QJsonObject tmpObj;
    QString fileName = getResourceDir() + "/style.json";
    QFile file(fileName);

    if (!file.exists(fileName))
    {
        qWarning() << "[Error]: No such style config file!";
        return tmpObj;
    }

    if (!file.open(QIODevice::ReadOnly))
    {
        qWarning() << "[Error]:Open style config file for read error!";
        return tmpObj;
    }

    QJsonDocument parseDoucment = QJsonDocument::fromJson(file.readAll());

    file.close();

    if(parseDoucment.isObject())
        tmpObj = parseDoucment.object();
    else
        qWarning() << "[Error]:Style config file value unavailable!";

    return tmpObj;
}

DWidgetStyleController::~DWidgetStyleController()
{

}


#ifndef DWIDGETSTYLECONTROLLER_H
#define DWIDGETSTYLECONTROLLER_H

#include <QObject>
#include <QDir>
#include <QFile>
#include <QVariant>
#include <QJsonDocument>
#include <QJsonObject>
#include <QFileSystemWatcher>
#include <QDebug>

class DWidgetStyleController : public QObject
{
    Q_OBJECT
    Q_ENUMS(WidgetStype)

    Q_PROPERTY(WidgetStype currentWidgetStyle READ getCurrentWidgetStyle NOTIFY currentWidgetStyleChanged)
public:
    enum WidgetStype{
        StyleWhite,
        StyleBlack
    };

    explicit DWidgetStyleController(QObject *parent = 0);
    ~DWidgetStyleController();

    WidgetStype getCurrentWidgetStyle();
    Q_INVOKABLE void setCurrentWidgetStyle(WidgetStype style);

signals:
    void currentWidgetStyleChanged();

private slots:
    void configFileChanged(const QString &path);

private:
    void init();
    void updateCurrentWidgetStyle(WidgetStype style);
    WidgetStype getWidgetStyleFromJson();

private:
    WidgetStype currentWidgetStyle;
    QFileSystemWatcher *fileWatcher;

    const QString CONFIG_FILE_DIR = QDir::homePath() + "/.local/share/DUI/";
    const QString CONFIG_FILE_NARMAL = QDir::homePath() + "/.local/share/DUI/WidgetStyle.json";
};

#endif // DWIDGETCONTROLLER_H

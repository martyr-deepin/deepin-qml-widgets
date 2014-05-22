#ifndef QMLLOADER_H
#define QMLLOADER_H

#include <QObject>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlContext>
#include <QDBusAbstractAdaptor>

class QmlLoader;
class DBusProxy;

class QmlLoader: public QObject{
    Q_OBJECT

public:
    QmlLoader(QObject* parent = 0);
    ~QmlLoader();

    QQmlEngine* engine;
    QQmlComponent* component;
    QQmlContext * rootContext;
    QObject * rootObject;

    void load(QUrl url);

    Q_INVOKABLE void actionInvoked(int appId, QString actionId);
private:
    DBusProxy * m_dbus_proxy;
};

class DBusProxy : public QDBusAbstractAdaptor {
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "com.deepin.dialog.uninstall")

public:
    DBusProxy(QmlLoader* parent);
    ~DBusProxy();

    Q_SLOT int Show(QString icon, QString message, QStringList actions);

    Q_SIGNAL void ActionInvoked(int, QString);

private:
    QmlLoader* m_parent;
};

#endif // QMLLOADER_H

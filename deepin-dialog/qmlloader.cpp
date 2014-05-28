
#include <QQmlEngine>
#include <QQmlComponent>
#include <QProcess>
#include <QDebug>
#include <QDBusConnection>
#include <QCoreApplication>

#include "qmlloader.h"

QmlLoader::QmlLoader(QObject *parent)
    :QObject(parent)
{
    engine = new QQmlEngine(this);
    component = new QQmlComponent(engine, this);
    rootContext = new QQmlContext(engine, this);
    m_dbus_proxy = new DBusProxy(this);
}

QmlLoader::~QmlLoader()
{
    delete this->m_dbus_proxy;
    delete this->rootContext;
    delete this->component;
    delete this->engine;
}


void QmlLoader::load(QUrl url)
{
    this->component->loadUrl(url);
    this->rootObject = this->component->beginCreate(this->rootContext);
    if ( this->component->isReady() )
        this->component->completeCreate();
    else
        qWarning() << this->component->errorString();
}

void QmlLoader::actionInvoked(int appId, QString actionId)
{
    Q_EMIT m_dbus_proxy->ActionInvoked(appId, actionId);
    QCoreApplication::exit(0);
}


DBusProxy::DBusProxy(QmlLoader *parent):
    QDBusAbstractAdaptor(parent),
    m_parent(parent)
{
    QDBusConnection::sessionBus().registerObject("/com/deepin/dialog", parent);
}

DBusProxy::~DBusProxy()
{

}

int DBusProxy::ShowUninstall(QString icon, QString message, QString warning, QStringList actions)
{
    QVariant appId;
    QMetaObject::invokeMethod(
                m_parent->rootObject,
                "showDialog",
                Q_RETURN_ARG(QVariant, appId),
                Q_ARG(QVariant, icon),
                Q_ARG(QVariant, message),
                Q_ARG(QVariant, warning),
                Q_ARG(QVariant, actions)
                );
    return appId.toInt();
}

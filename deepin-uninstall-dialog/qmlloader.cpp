
#include <QQmlEngine>
#include <QQmlComponent>
#include <QProcess>
#include <QDebug>
#include <QDBusConnection>

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


DBusProxy::DBusProxy(QmlLoader *parent):
    QDBusAbstractAdaptor(parent),
    m_parent(parent)
{
    QDBusConnection::sessionBus().registerObject("/com/deepin/dialog/uninstall", parent);
}

DBusProxy::~DBusProxy()
{

}

void DBusProxy::Show(QString icon, QString message, QStringList actions)
{
    QMetaObject::invokeMethod(m_parent->rootObject, "showDialog", Q_ARG(QVariant, icon), Q_ARG(QVariant, message), Q_ARG(QVariant, actions));
}

#include <QGuiApplication>
#include <QQmlEngine>
#include <QCoreApplication>
#include <QDebug>
#include <QDBusConnection>

#include "qmlloader.h"

int main(int argc, char* argv[])
{
    QCoreApplication::setAttribute(Qt::AA_X11InitThreads, true);
    QGuiApplication app(argc, argv);
    if(QDBusConnection::sessionBus().registerService("com.deepin.dialog")){

        QmlLoader* qmlLoader = new QmlLoader();
        qmlLoader->rootContext->setContextProperty("mainObject", qmlLoader);
        qmlLoader->load(QUrl("qrc:///qml/main.qml"));
        QObject::connect(qmlLoader->engine, SIGNAL(quit()), QCoreApplication::instance(), SLOT(quit()));

        return app.exec();
    }
    else{
        qWarning() << "is running...";
        return 0;
    }
}

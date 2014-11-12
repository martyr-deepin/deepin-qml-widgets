
#include "qmlloader.h"

#include <QApplication>
#include <QQmlEngine>
#include <QDebug>
#include <QDBusConnection>

int main(int argc, char* argv[])
{
    QApplication::setAttribute(Qt::AA_X11InitThreads, true);
    QApplication app(argc, argv);
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

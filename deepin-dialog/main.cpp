/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/


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

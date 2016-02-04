/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/


#ifndef __DBUS_H__
#define __DBUS_H__


#include "deepinlocale.h"
#include <QQmlExtensionPlugin>
#include <qqml.h>

class DBusPlugin: public QQmlExtensionPlugin
{
    Q_OBJECT
	Q_PLUGIN_METADATA(IID "deepin.locale.tools")

    public:
	void registerTypes(const char* uri) { 
	    qmlRegisterType<DLocale>(uri, 1, 0, "DLocale");
    }
};
#endif


/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

#ifndef DWINDOW_PLUGIN_H
#define DWINDOW_PLUGIN_H

#include <QQmlExtensionPlugin>

class DockAppletPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "Deepin.Widgets")

public:
    void registerTypes(const char *uri);
};

#endif // DWINDOW_PLUGIN_H


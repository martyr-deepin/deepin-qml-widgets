
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


#include "deepinwidgets_plugin.h"
#include "deepinwidgets.h"

#include <qqml.h>

void DeepinWidgetsPlugin::registerTypes(const char *uri)
{
    // @uri com.deepin.qmlwidgets
    qmlRegisterType<DeepinWidgets>(uri, 1, 0, "DeepinWidgets");
}



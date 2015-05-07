#include "plugins/plugin.h"
#include "plugins/dwindow.h"
#include "plugins/dicon.h"
#include "plugins/previewwindow.h"
#include "plugins/dfiledialog.h"
#include "plugins/dsinglelinetip.h"
#include "plugins/dfilechoosedialogaide.h"
#include "plugins/dwidgetstylecontroller.h"
#include "plugins/keysutils.h"

#include <qqml.h>

static QObject* keysutils_singleton_provider(QQmlEngine *engine,
                                           QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    KeysUtils *utils = new KeysUtils();
    return utils;
}

void DockAppletPlugin::registerTypes(const char *uri)
{
    //@uri Deepin.Widgets
    qmlRegisterSingletonType<KeysUtils>(uri, 1, 0, "KeysUtils", keysutils_singleton_provider);

    qmlRegisterType<DOverrideWindow>(uri, 1, 0, "DOverrideWindow");
    qmlRegisterType<DWindow>(uri, 1, 0, "DWindow");
    qmlRegisterType<DIcon>(uri, 1, 0, "DIcon");
    qmlRegisterType<DPreviewWindow>(uri, 1, 0, "DPreviewWindow");
    qmlRegisterType<DFileDialog>(uri, 1, 0, "DFileDialog");
    qmlRegisterType<DSingleLineTip>(uri, 1, 0, "DSingleLineTip");
    qmlRegisterType<DFileChooseDialogAide>(uri, 1, 0, "DFileChooseDialogAide");
    qmlRegisterType<DWidgetStyleController>(uri, 1, 0, "DWidgetStyleController");
}

#include "plugins/plugin.h"
#include "plugins/dwindow.h"
#include "plugins/dicon.h"
#include "plugins/previewwindow.h"
#include "plugins/dfiledialog.h"
#include "plugins/dsinglelinetip.h"
#include "plugins/dfilechoosedialogaide.h"
#include "plugins/dwidgetstylecontroller.h"

#include <qqml.h>

void DockAppletPlugin::registerTypes(const char *uri)
{
    //@uri Deepin.Widgets
    qmlRegisterType<DOverrideWindow>(uri, 1, 0, "DOverrideWindow");
    qmlRegisterType<DWindow>(uri, 1, 0, "DWindow");
    qmlRegisterType<DIcon>(uri, 1, 0, "DIcon");
    qmlRegisterType<DPreviewWindow>(uri, 1, 0, "DPreviewWindow");
    qmlRegisterType<DFileDialog>(uri, 1, 0, "DFileDialog");
    qmlRegisterType<DSingleLineTip>(uri, 1, 0, "DSingleLineTip");
    qmlRegisterType<DFileChooseDialogAide>(uri, 1, 0, "DFileChooseDialogAide");
    qmlRegisterType<DWidgetStyleController>(uri, 1, 0, "DWidgetStyleController");
}

#ifndef DEEPINWIDGETS_PLUGIN_H
#define DEEPINWIDGETS_PLUGIN_H

#include <QQmlExtensionPlugin>

class DeepinWidgetsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // DEEPINWIDGETS_PLUGIN_H


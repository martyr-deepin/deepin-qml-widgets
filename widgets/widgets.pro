TEMPLATE = lib
TARGET = DeepinWidgets
QT += qml quick
CONFIG += qt plugin

HEADERS += \
    plugins/dicon.h \
    plugins/dwindow.h \
    plugins/plugin.h

SOURCES += \
    plugins/dicon.cpp \
    plugins/dwindow.cpp \
    plugins/plugin.cpp

TARGET = $$qtLibraryTarget($$TARGET)
uri = Deepin.Widgets

qmldir.files += *.qml qmldir images

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += qmldir target
}

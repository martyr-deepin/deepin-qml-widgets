TEMPLATE = lib
TARGET = DeepinWidgets
QT += qml quick gui x11extras opengl
CONFIG += qt plugin c++11 link_pkgconfig
PKGCONFIG += xcomposite xcb-damage


HEADERS += \
    plugins/dicon.h \
    plugins/dwindow.h \
    plugins/plugin.h \
    plugins/previewwindow.h \
    plugins/dfiledialog.h

SOURCES += \
    plugins/dicon.cpp \
    plugins/dwindow.cpp \
    plugins/previewwindow.cpp \
    plugins/plugin.cpp \
    plugins/dfiledialog.cpp

TARGET = $$qtLibraryTarget($$TARGET)
uri = Deepin.Widgets

qmldir.files += *.qml qmldir images

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += qmldir target
}

LIBS += -lxcb

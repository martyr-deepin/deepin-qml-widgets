TEMPLATE = lib
TARGET = DeepinWidgets
QT += qml quick gui x11extras opengl widgets
CONFIG += qt plugin c++11 link_pkgconfig
PKGCONFIG += xcomposite xcb-damage


HEADERS += \
    plugins/dicon.h \
    plugins/dwindow.h \
    plugins/plugin.h \
    plugins/previewwindow.h \
    plugins/dfiledialog.h \
    plugins/dsinglelinetip.h\
    plugins/dfilechoosedialogaide.h \
    plugins/dwidgetstylecontroller.h

SOURCES += \
    plugins/dicon.cpp \
    plugins/dwindow.cpp \
    plugins/previewwindow.cpp \
    plugins/plugin.cpp \
    plugins/dfiledialog.cpp \
    plugins/dsinglelinetip.cpp\
    plugins/dfilechoosedialogaide.cpp \
    plugins/dwidgetstylecontroller.cpp

TARGET = $$qtLibraryTarget($$TARGET)
uri = Deepin.Widgets

qmldir.files += *.qml qmldir images plugins.qmltypes

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += qmldir target
}

CONFIG += link_pkgconfig
PKGCONFIG += gtk+-2.0
PKGCONFIG += xcb

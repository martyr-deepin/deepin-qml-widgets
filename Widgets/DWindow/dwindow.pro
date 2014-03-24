TEMPLATE = lib
TARGET = dwindow
QT += qml quick
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
uri = Deepin.Widgets

# Input
SOURCES += \
    Widgets/DWindow/plugin.cpp \
    Widgets/DWindow/dwindow.cpp

HEADERS += \
    Widgets/DWindow/plugin.h \
    Widgets/DWindow/dwindow.h

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    target.path = $$installPath
    INSTALLS += target
}


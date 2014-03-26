TEMPLATE = lib
TARGET = dwindow
QT += qml quick
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
uri = Deepin.Window

# Input
SOURCES += \
    plugin.cpp \
    dwindow.cpp

HEADERS += \
    plugin.h \
    dwindow.h

qmldir.files += qmldir

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}


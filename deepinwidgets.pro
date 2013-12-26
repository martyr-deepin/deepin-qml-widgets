TEMPLATE = lib
TARGET = DeepinWidgets
QT += qml quick
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
uri = Deepin.Widgets

qmldir.files += Widgets/*

unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS = qmldir
}


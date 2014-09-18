TEMPLATE = lib
CONFIC += plugin
QT += qml dbus

TARGET = dlocale
DESTDIR = Deepin/Locale

HEADERS += plugin.h deepinlocale.h

target.path = $$[QT_INSTALL_QML]/Deepin/Locale

qmldir.path = $$[QT_INSTALL_QML]/Deepin/Locale
qmldir.files += qmldir plugins.qmltypes
INSTALLS += target qmldir

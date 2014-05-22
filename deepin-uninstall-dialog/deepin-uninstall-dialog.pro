TEMPLATE = app

QT += quick qml gui core dbus

SOURCES += main.cpp \
    helper.cpp \
    qmlloader.cpp

HEADERS += \
    helper.h \
    qmlloader.h

RESOURCES += \
    qml.qrc \

#VARIABLES
isEmpty(PREFIX) {
    PREFIX = /usr
}
BINDIR = $$PREFIX/bin

target.path =$$BINDIR

service.files += data/com.deepin.dialog.uninstall.service
service.path = /usr/share/dbus-1/services/

INSTALLS += target service

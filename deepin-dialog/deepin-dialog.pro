TEMPLATE = app

QT += quick qml gui core dbus

SOURCES += main.cpp \
    qmlloader.cpp

HEADERS += \
    qmlloader.h

RESOURCES += \
    qml.qrc \

#VARIABLES
isEmpty(PREFIX) {
    PREFIX = /usr
}
BINDIR = $$PREFIX/bin

target.path =$$BINDIR

service.files += data/com.deepin.dialog.service
service.path = /usr/share/dbus-1/services/

INSTALLS += target service

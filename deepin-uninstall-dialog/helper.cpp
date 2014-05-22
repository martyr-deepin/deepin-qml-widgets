#include "helper.h"

#include <QProcess>
#include <QCoreApplication>

ExternalObject::ExternalObject(QObject *parent)
    :QObject(parent)
{

}

void ExternalObject::xdgOpen(QString path)
{
    QProcess::execute("xdg-open " + path);
}

void ExternalObject::exitWithCode(int code)
{
    qDebug() << "Click code:" << code;
    QCoreApplication::exit(code);
}

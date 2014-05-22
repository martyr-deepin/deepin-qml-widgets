#ifndef RESOURCE_H
#define RESOURCE_H

#include <QObject>
#include <QDebug>

class ExternalObject : public QObject
{
    Q_OBJECT
public:
    ExternalObject(QObject *parent = 0);

    Q_INVOKABLE void xdgOpen(QString path);
    Q_INVOKABLE void exitWithCode(int code);
};

#endif // RESOURCE_H

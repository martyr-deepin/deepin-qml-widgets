#ifndef KEYSUTILS_H
#define KEYSUTILS_H

#include <QObject>
#include <QVariantMap>

class KeysUtils : public QObject
{
    Q_OBJECT
public:
    explicit KeysUtils(QObject *parent = 0);

public slots:
    // keys related
    void overrideShortcut(QString oldShortcut, QString newShortcut);
    QString getOverriddenShortcut(QString shortcut);
    QString keyEventToString(int modifiers, int key);
    bool isKeyEventEqualToString(int modifiers, int key, QString targetString);

private:
    QVariantMap m_overriddenShortcuts;
};

#endif // KEYSUTILS_H

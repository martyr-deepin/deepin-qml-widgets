#include "keysutils.h"
#include <QKeySequence>

KeysUtils::KeysUtils(QObject *parent) :
    QObject(parent)
{
    // add overridden keys
    overrideShortcut("Meta", "Super");
    overrideShortcut("PgUp", "PageUp");
    overrideShortcut("PgDown", "PageDown");
}

void KeysUtils::overrideShortcut(QString oldShortcut, QString newShortcut)
{
    m_overriddenShortcuts[oldShortcut] = newShortcut;
}

QString KeysUtils::getOverriddenShortcut(QString shortcut)
{
    return m_overriddenShortcuts.value(shortcut, shortcut).value<QString>();
}

QString KeysUtils::keyEventToString(int modifiers, int key)
{
    QString sequence = QKeySequence(modifiers + key).toString();
    return getOverriddenShortcut(sequence);
}

bool KeysUtils::isKeyEventEqualToString(int modifiers, int key, QString targetString)
{
    QString sequence = QKeySequence(modifiers + key).toString();
    return sequence == targetString || sequence == getOverriddenShortcut(targetString);
}

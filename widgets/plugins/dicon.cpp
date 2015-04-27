#include <QIcon>
#include <QDir>
#include <QString>
#include <QStringList>
#include <QDebug>
#include <QPainter>
#include <QProcess>
#include <QMimeDatabase>
#include <QMimeType>

#include "plugins/dicon.h"

#undef signals
extern "C" {
  #include <gtk/gtk.h>
}
#define signals public

DIcon::DIcon(QQuickPaintedItem *parent)
    : QQuickPaintedItem(parent)
{

}

DIcon::~DIcon()
{

}

QString DIcon::iconNameToPath(QString qname, int size)
{
    char *name = qname.toUtf8().data();
    GtkIconTheme* theme;

    if (g_path_is_absolute(name))
        return qname;
    g_return_val_if_fail(name != NULL, NULL);

    int pic_name_len = strlen(name);
    char* ext = strrchr(name, '.');
    if (ext != NULL) {
        if (g_ascii_strcasecmp(ext+1, "png") == 0 || g_ascii_strcasecmp(ext+1, "svg") == 0 || g_ascii_strcasecmp(ext+1, "jpg") == 0) {
            pic_name_len = ext - name;
            g_debug("Icon name should an absoulte path or an basename without extension");
        }
    }

    char* pic_name = g_strndup(name, pic_name_len);
    theme = gtk_icon_theme_get_default();
    /*
    if(theme_name == NULL){
        theme = gtk_icon_theme_get_default();
    }
    else{
        theme = gtk_icon_theme_new();
        char *theme_name = this->m_theme.toUtf8().data();
        gtk_icon_theme_set_custom_theme(theme, theme_name);
    }*/

    GtkIconInfo* info = gtk_icon_theme_lookup_icon(theme, pic_name, size, GTK_ICON_LOOKUP_NO_SVG);
    g_free(pic_name);
    if (info) {
        char* path = g_strdup(gtk_icon_info_get_filename(info));
#if GTK_MAJOR_VERSION >= 3
        g_object_unref(info);
#elif GTK_MAJOR_VERSION == 2
        gtk_icon_info_free(info);
#endif
        return QString(path);
    } else {
        return NULL;
    }
}

void DIcon::setTheme(const QString &v)
{
    qWarning() << "[DIcon] theme property is departed";
    m_theme = v;
    Q_EMIT themeChanged(v);
    QRect rect = QRect(0, 0, this->width(), this->height());
    this->update(rect);
}

void DIcon::setIcon(const QString &v)
{
    m_icon = v;
    Q_EMIT iconChanged(v);
    QRect rect = QRect(0, 0, this->width(), this->height());
    this->update(rect);
}

void DIcon::paint(QPainter *painter)
{
    QPixmap pixmap;
    int size = this->width() < this->height() ? this->width():this->height();
    if(m_icon.startsWith("data:image/") &&
            m_icon.split(",")[0].split(";")[1] == "base64"){
        // check data image uri
        pixmap = QPixmap(this->width(), this->height());
        QStringList tmpInfo = m_icon.split(",");
        const char *format = tmpInfo[0].split(";")[0].split("/")[1].toUtf8().data();
        const char *base64data = tmpInfo[1].toUtf8().data();
        qDebug() << "[DIcon] get data image uri, format:" << format;
        pixmap.loadFromData(QByteArray::fromBase64(QByteArray(base64data)), format);
    }
    else{
        QString iconPath = iconNameToPath(m_icon, size);
        if(iconPath == NULL){
            iconPath = iconNameToPath("application-default-icon", size);
        }
        qDebug() << "[DIcon] icon name: " << m_icon << ", icon path: " << iconPath;
        QIcon icon = QIcon(iconPath);
        pixmap = icon.pixmap(this->width(), this->height());
    }
    pixmap = pixmap.scaled(this->width(), this->height());
    QRect rect = QRect(0, 0, this->width(), this->height());
    painter->drawPixmap(rect, pixmap, rect);
}

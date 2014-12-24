#ifndef DFILEDIALOG_H
#define DFILEDIALOG_H

#include <QQuickItem>
#include <xcb/xcb.h>
#include <xcb/xproto.h>

class QWindow;
class QFileDialog;
class DFileDialog : public QQuickItem
{
    Q_OBJECT
public:
    explicit DFileDialog(QQuickItem *parent = 0);
    ~DFileDialog();

    Q_PROPERTY(QUrl fileUrl READ fileUrl)
    Q_PROPERTY(QList<QUrl> fileUrls READ fileUrls)
    Q_PROPERTY(QUrl folder READ folder WRITE setFolder)
    Q_PROPERTY(Qt::WindowModality modality READ modality WRITE setModality)
    Q_PROPERTY(QList<QString> nameFilters READ nameFilters WRITE setNameFilters)
    Q_PROPERTY(bool selectExisting READ selectExisting WRITE setSelectExisting)
    Q_PROPERTY(bool selectFolder READ selectFolder WRITE setSelectFolder)
    Q_PROPERTY(bool selectMultiple READ selectMultiple WRITE setSelectMultiple)
    Q_PROPERTY(QString selectedNameFilter READ selectedNameFilter WRITE selectNameFilter)
    Q_PROPERTY(QString title READ title WRITE setTitle)
    Q_PROPERTY(bool visible READ isVisible WRITE setVisible)
    Q_PROPERTY(bool saveMode READ isSaveMode WRITE setSaveMode)

    Q_PROPERTY(QString defaultFileName READ defaultFileName WRITE setDefaultFileName)

    Q_PROPERTY(QWindow* transientParent READ transientParent WRITE setTransientParent)

    QUrl fileUrl();

    QList<QUrl> fileUrls();

    QUrl folder();
    void setFolder(QUrl folder);

    Qt::WindowModality modality();
    void setModality(Qt::WindowModality modality);

    QStringList nameFilters();
    void setNameFilters(QStringList nameFilters);

    QString selectedNameFilter();
    void selectNameFilter(QString nameFilter);

    bool selectExisting();
    void setSelectExisting(bool selectExisting);

    bool selectFolder();
    void setSelectFolder(bool selectFolder);

    bool selectMultiple();
    void setSelectMultiple(bool selectMultiple);

    QString title();
    void setTitle(QString title);

    bool isVisible();
    void setVisible(bool visible);

    bool isSaveMode();
    void setSaveMode(bool saveMode);

    QString defaultFileName();
    void setDefaultFileName(QString defaultFileName);

    QWindow* transientParent();
    void setTransientParent(QWindow*);

    Q_INVOKABLE void open();
    Q_INVOKABLE void close();

signals:
    void accepted();
    void rejected();

private:
    xcb_connection_t *m_conn;
    QFileDialog *m_fileDialog;

    bool m_selectMultiple;
    bool m_selectExisting;
    bool m_selectFolder;
    QString m_defaultFileName;
    QWindow *m_transientParent;

    QString m_domain;

    void setFileModeInternal();
    void checkFileNameDuplication();
    void setTransientParentInternal();
    QString tr(const char*, bool flag);

private slots:
    void directoryEnteredSlot(const QString&);
};

#endif // DFILEDIALOG_H

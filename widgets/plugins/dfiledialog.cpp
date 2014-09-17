#include "dfiledialog.h"
#include <QFileDialog>

DFileDialog::DFileDialog(QQuickItem *parent) :
    QQuickItem(parent)
{
    m_fileDialog = new QFileDialog();
    connect(m_fileDialog, SIGNAL(accepted()), this, SIGNAL(accepted()));
    connect(m_fileDialog, SIGNAL(rejected()), this, SIGNAL(rejected()));

    this->setSelectExisting(true);
    this->setSelectFolder(false);
    this->setSelectMultiple(false);
}

DFileDialog::~DFileDialog()
{
    m_fileDialog->deleteLater();
}

QUrl DFileDialog::fileUrl()
{
    QList<QUrl> selectedFiles = m_fileDialog->selectedUrls();
    return selectedFiles.length() == 1 ? selectedFiles.at(0) : QUrl();
}

QList<QUrl> DFileDialog::fileUrls()
{
    return m_fileDialog->selectedUrls();
}

QUrl DFileDialog::folder()
{
    return m_fileDialog->directoryUrl();
}

void DFileDialog::setFolder(QUrl folder)
{
    m_fileDialog->setDirectoryUrl(folder);
}

Qt::WindowModality DFileDialog::modality()
{
    return m_fileDialog->windowModality();
}

void DFileDialog::setModality(Qt::WindowModality modality)
{
    m_fileDialog->setWindowModality(modality);
}

QStringList DFileDialog::nameFilters()
{
    return m_fileDialog->nameFilters();
}

void DFileDialog::setNameFilters(QStringList nameFilters)
{
    m_fileDialog->setNameFilters(nameFilters);
}

QString DFileDialog::selectedNameFilter()
{
    return m_fileDialog->selectedNameFilter();
}

void DFileDialog::selectNameFilter(QString nameFilter)
{
    m_fileDialog->selectNameFilter(nameFilter);
}

bool DFileDialog::selectExisting()
{
    return m_selectExisting;
}

void DFileDialog::setSelectExisting(bool selectExisting)
{
    m_selectExisting = selectExisting;
    m_setFileModeInternal();
}

bool DFileDialog::selectFolder()
{
    return m_selectFolder;
}

void DFileDialog::setSelectFolder(bool selectFolder)
{
    m_selectFolder = selectFolder;
    m_setFileModeInternal();
}

bool DFileDialog::selectMultiple()
{
    return m_selectMultiple;
}

void DFileDialog::setSelectMultiple(bool selectMultiple)
{
    m_selectMultiple = selectMultiple;
    m_setFileModeInternal();
}

QString DFileDialog::defaultFileName()
{
    return m_defaultFileName;
}

void DFileDialog::setDefaultFileName(QString defaultFileName)
{
    m_defaultFileName = defaultFileName;
    m_fileDialog->selectFile(m_defaultFileName);
}

QString DFileDialog::title()
{
    return m_fileDialog->windowTitle();
}

void DFileDialog::setTitle(QString title)
{
    m_fileDialog->setWindowTitle(title);
}

bool DFileDialog::isVisible()
{
    return m_fileDialog->isVisible();
}

void DFileDialog::setVisible(bool visible)
{
    m_fileDialog->setVisible(visible);
}

bool DFileDialog::isSaveMode()
{
    return m_fileDialog->acceptMode() == m_fileDialog->AcceptSave;
}

void DFileDialog::setSaveMode(bool saveMode)
{
    m_fileDialog->setAcceptMode(saveMode ? m_fileDialog->AcceptSave : m_fileDialog->AcceptOpen);
}

void DFileDialog::open()
{
    m_fileDialog->show();
}

void DFileDialog::close()
{
    m_fileDialog->close();
}

void DFileDialog::m_setFileModeInternal()
{
    if (m_selectFolder) {
        m_fileDialog->setFileMode(m_fileDialog->DirectoryOnly);
    } else {
        if (m_selectMultiple) {
            m_fileDialog->setFileMode(m_selectExisting ? m_fileDialog->ExistingFiles : m_fileDialog->AnyFile);
        } else {
            m_fileDialog->setFileMode(m_selectExisting ? m_fileDialog->ExistingFile : m_fileDialog->AnyFile);
        }
    }
}

/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

#include "dfiledialog.h"
#include <QFileDialog>
#include <QWindow>
#include <QX11Info>
#include <libintl.h>

DFileDialog::DFileDialog(QQuickItem *parent) :
    QQuickItem(parent),
    m_transientParent(NULL)
{
    m_domain = "deepin-qml-widgets";
    setlocale(LC_ALL, "");
    bindtextdomain(m_domain.toLatin1(), "/usr/share/locale");
    m_conn = QX11Info::connection();

    m_fileDialog = new QFileDialog();
    m_fileDialog->setLabelText(m_fileDialog->LookIn, tr("Look in", true));
    m_fileDialog->setLabelText(m_fileDialog->FileType, tr("Files of type", true));

    connect(m_fileDialog, SIGNAL(accepted()), this, SIGNAL(accepted()));
    connect(m_fileDialog, SIGNAL(rejected()), this, SIGNAL(rejected()));
    connect(m_fileDialog, SIGNAL(directoryEntered(QString)), this, SLOT(directoryEnteredSlot(QString)));

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
    setFileModeInternal();
}

bool DFileDialog::selectFolder()
{
    return m_selectFolder;
}

void DFileDialog::setSelectFolder(bool selectFolder)
{
    m_selectFolder = selectFolder;
    setFileModeInternal();
}

bool DFileDialog::selectMultiple()
{
    return m_selectMultiple;
}

void DFileDialog::setSelectMultiple(bool selectMultiple)
{
    m_selectMultiple = selectMultiple;
    setFileModeInternal();
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

QWindow* DFileDialog::transientParent()
{
    return m_transientParent;
}

void DFileDialog::setTransientParent(QWindow *transientParent)
{
    m_transientParent = transientParent;
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
    if (!m_selectFolder) {
        m_fileDialog->setLabelText(m_fileDialog->Accept, saveMode ? tr("Save", true) : tr("Open", true));
    }
    m_fileDialog->setAcceptMode(saveMode ? m_fileDialog->AcceptSave : m_fileDialog->AcceptOpen);
}

void DFileDialog::open()
{
    // don't know why, but if we don't set this everytime we open the dialog
    // the Reject label may happen to be not translated.
    m_fileDialog->setLabelText(m_fileDialog->Reject, tr("Cancel", true));
    m_fileDialog->setOptions(m_fileDialog->options() | m_fileDialog->DontConfirmOverwrite);
    m_fileDialog->selectFile(m_defaultFileName);
    checkFileNameDuplication();

    m_fileDialog->show();
    setTransientParentInternal();
}

void DFileDialog::close()
{
    m_fileDialog->close();
}

void DFileDialog::setFileModeInternal()
{
    if (m_selectFolder) {
        m_fileDialog->setFileMode(m_fileDialog->DirectoryOnly);

        m_fileDialog->setLabelText(m_fileDialog->FileName, tr("Directory", true));
        m_fileDialog->setLabelText(m_fileDialog->Accept, tr("Select", true));
    } else {
        if (m_selectMultiple) {
            m_fileDialog->setFileMode(m_selectExisting ? m_fileDialog->ExistingFiles : m_fileDialog->AnyFile);
        } else {
            m_fileDialog->setFileMode(m_selectExisting ? m_fileDialog->ExistingFile : m_fileDialog->AnyFile);
        }

        m_fileDialog->setLabelText(m_fileDialog->FileName, tr("File name", true));
        m_fileDialog->setLabelText(m_fileDialog->Accept, tr("Open", true));
    }
}

QString DFileDialog::tr(const char *s, bool)
{
    return dgettext(m_domain.toLatin1(), s);
}

void DFileDialog::directoryEnteredSlot(const QString&) {
    checkFileNameDuplication();
}

void DFileDialog::checkFileNameDuplication()
{
    if (defaultFileName().trimmed() != "") {
        bool exist = QFile(m_fileDialog->selectedFiles().at(0)).exists();
        int copyNum = 0;
        QString newDefaultName;

        while (exist) {
            copyNum++;

            QStringList fileNameParts = defaultFileName().split(".");
            QString name(fileNameParts.at(0));
            QString suffix(fileNameParts.length() > 1 ? QString(".%1").arg(fileNameParts.at(1)) : "");

            newDefaultName = name + QString::number(copyNum) + suffix;
            exist = QFile(m_fileDialog->directory().absolutePath() + QDir::separator() + newDefaultName).exists();
        }

        m_fileDialog->selectFile(newDefaultName);
    }
}

void DFileDialog::setTransientParentInternal()
{
    if (m_transientParent) {
        xcb_window_t winId = m_transientParent->winId();

        xcb_void_cookie_t cookie = xcb_change_property_checked(m_conn, XCB_PROP_MODE_REPLACE, m_fileDialog->winId(),
                                                               XCB_ATOM_WM_TRANSIENT_FOR, XCB_ATOM_WINDOW, 32,
                                                               1, &winId);
        xcb_request_check(m_conn, cookie);
        xcb_flush(m_conn);
    }
}

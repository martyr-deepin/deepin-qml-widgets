#include "dwindow.h"

DOverrideWindow::DOverrideWindow(QQuickWindow *parent)
    :QQuickWindow(parent)
{
    QSurfaceFormat sformat;
    sformat.setAlphaBufferSize(8);
    this->setFormat(sformat);
    this->setClearBeforeRendering(true);

    this->setFlags(Qt::Popup);
}

DOverrideWindow::~DOverrideWindow()
{
}

DWindow::DWindow(QQuickWindow *parent)
    :QQuickWindow(parent)
{
    QSurfaceFormat sformat;
    sformat.setAlphaBufferSize(8);
    this->setFormat(sformat);
    this->setClearBeforeRendering(true);
}
DWindow::~DWindow()
{
}

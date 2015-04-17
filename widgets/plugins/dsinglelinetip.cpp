#include "dsinglelinetip.h"

DSingleLineTip::DSingleLineTip(QWidget * parent) :
    QWidget(parent)
{
    this->setWindowFlags(Qt::FramelessWindowHint | Qt::ToolTip | Qt::WindowStaysOnTopHint);
    this->setAttribute(Qt::WA_TranslucentBackground);

    m_destroyTimer = new QTimer();
    connect(m_destroyTimer, SIGNAL(timeout()), this, SLOT(close()));

    QGraphicsDropShadowEffect * efect = new QGraphicsDropShadowEffect;
    efect->setBlurRadius(3);
    efect->setXOffset(1);
    efect->setYOffset(1);
    efect->setColor(QColor("#010101"));
    this->setGraphicsEffect(efect);
}

void DSingleLineTip::showTip()
{
    m_destroyTimer->stop();

    if (this->isHidden())
    {
        this->show();
    }

    this->repaint();
}

void DSingleLineTip::showTipAtLeft()
{
    m_destroyTimer->stop();

    if (this->isHidden())
    {
        this->show();
    }

    this->arrowDirection = DSingleLineTip::arrowLeft;
    this->repaint();
}

void DSingleLineTip::showTipAtRight()
{
    m_destroyTimer->stop();

    if (this->isHidden())
    {
        this->show();
    }

    this->arrowDirection = DSingleLineTip::arrowRight;
    this->repaint();
}

void DSingleLineTip::showTipAtTop()
{
    m_destroyTimer->stop();

    if (this->isHidden())
    {
        this->show();
    }

    this->arrowDirection = DSingleLineTip::arrowTop;
    this->repaint();
}

void DSingleLineTip::showTipAtBottom()
{
    m_destroyTimer->stop();

    if (this->isHidden())
    {
        this->show();
    }

    this->arrowDirection = DSingleLineTip::arrowBottom;
    this->repaint();
}

void DSingleLineTip::destroyTip()
{
    if (destroyInterval > 0)
        m_destroyTimer->start(destroyInterval);
    else
        this->close();
}

// override methods
void DSingleLineTip::paintEvent(QPaintEvent *)
{
    QPainter painter(this);
    painter.setRenderHint(QPainter::Antialiasing);

    QPainterPath border;
    QRectF textRec;

    switch (arrowDirection)
    {
    case DSingleLineTip::arrowLeft:
        border = getLeftCornerPath();
        textRec = QRectF(arrowHeight,0,this->width - arrowHeight, this->height);
        break;
    case DSingleLineTip::arrowRight:
        border = getRightCornerPath();
        textRec = QRectF(0,0,this->width - arrowHeight, this->height);
        break;
    case DSingleLineTip::arrowTop:
        border = getTopCornerPath();
        textRec = QRectF(0,arrowHeight,this->width, this->height - arrowHeight);
        break;
    case DSingleLineTip::arrowBottom:
        border = getBottomCornerPath();
        textRec = QRectF(0,0,this->width, this->height - arrowHeight);
        break;
    default:
        border = getRightCornerPath();
        textRec = QRectF(0,0,this->width - arrowHeight, this->height);
    }

    QPen strokePen;
    strokePen.setColor(borderColor);
    strokePen.setWidth(borderWidth);
    painter.strokePath(border, strokePen);
    painter.fillPath(border, QBrush(backgroundColor.name() == "" ? Qt::black : backgroundColor));

    QPen penHText(QColor(textColor == "" ? "#00e0fc" : textColor));
    QFont textFont = painter.font();
    textFont.setPixelSize(fontPixelSize);
    painter.setFont(textFont);
    painter.setPen(penHText);
    painter.drawText(textRec, this->toolTip, Qt::AlignHCenter | Qt::AlignVCenter);

}


int DSingleLineTip::getX()
{
    return this->x;
}

int DSingleLineTip::getY()
{
    return this->y;
}

int DSingleLineTip::getWidth()
{
    return this->width;
}

int DSingleLineTip::getHeight()
{
    return this->height;
}

int DSingleLineTip::getRadius()
{
    return this->radius;
}

int DSingleLineTip::getArrowHeight()
{
    return this->arrowHeight;
}

int DSingleLineTip::getArrowWidth()
{
    return this->arrowWidth;
}

int DSingleLineTip::getArrowLeftMargin()
{
    return this->arrowLeftMargin;
}

int DSingleLineTip::getDestroyInterval()
{
    return this->destroyInterval;
}

int DSingleLineTip::getBorderWidth()
{
    return this->borderWidth;
}

int DSingleLineTip::getFontPixelSize()
{
    return this->fontPixelSize;
}

int DSingleLineTip::getShadowWidth()
{
    return this->shadowWidth;
}

QString DSingleLineTip::getShadowColor()
{
    return this->shadowColor.name();
}

QString DSingleLineTip::getBorderColor()
{
    return this->borderColor.name();
}

QColor DSingleLineTip::getBackgroundColor()
{
    return this->backgroundColor;
}

QString DSingleLineTip::getTextColor()
{
    return this->textColor;
}

QString DSingleLineTip::getToolTip()
{
    return this->toolTip;
}

void DSingleLineTip::setX(int value)
{
    this->x = value;
    this->move(this->x, this->y);
    emit xChanged();
}

void DSingleLineTip::setY(int value)
{
    this->y = value;
    this->move(this->x, this->y);
    emit yChanged();
}

void DSingleLineTip::setWidth(int value)
{
    this->width = value;
    this->setMinimumWidth(value);
    this->setMaximumWidth(value);
    emit widthChanged();
}

void DSingleLineTip::setHeight(int value)
{
    this->height = value;
    this->setMinimumHeight(value);
    this->setMaximumHeight(value);
    emit heightChanged();
}

void DSingleLineTip::setRadius(int value)
{
    this->radius = value;
    emit radiusChanged();
}

void DSingleLineTip::setArrowHeight(int value)
{
    this->arrowHeight = value;
    emit arrowHeightChanged();
}

void DSingleLineTip::setArrowWidth(int value)
{
    this->arrowWidth = value;
    emit arrowWidthChanged();
}

void DSingleLineTip::setArrowLeftMargin(int value)
{
    this->arrowLeftMargin = value;
    emit arrowLeftMarginChanged();
}

void DSingleLineTip::setDestroyInterval(int value)
{
    this->destroyInterval = value;
    emit destroyIntervalChanged();
}

void DSingleLineTip::setBorderWidth(int value)
{
    this->borderWidth = value;
    emit borderWidthChanged();
}

void DSingleLineTip::setFontPixelSize(int value)
{
    this->fontPixelSize = value;
    emit fontPixelSizeChanged();
}

void DSingleLineTip::setShadowWidth(int value)
{
    this->shadowWidth = value;
    emit shadowWidthChanged();
}

void DSingleLineTip::setShadowColor(QString value)
{
    this->shadowColor = QColor(value);
    emit shadowColorChanged();
}

void DSingleLineTip::setBorderColor(QString value)
{
    this->borderColor = QColor(value);
    emit borderColorChanged();
}

void DSingleLineTip::setBackgroundColor(QColor value)
{
    this->backgroundColor = value;
    emit backgroundColorChanged();
}

void DSingleLineTip::setTextColor(QString value)
{
    this->textColor = value;
    emit textColorChanged();
}

void DSingleLineTip::setToolTip(QString value)
{
    this->toolTip = value;
    emit toolTipChanged();
}


QPainterPath DSingleLineTip::getLeftCornerPath()
{
    QRect rect = this->rect().marginsRemoved(QMargins(shadowWidth,shadowWidth,shadowWidth,shadowWidth));

    QPoint cornerPoint(rect.x(), rect.y() + rect.height() / 2);
    QPoint topLeft(rect.x() + arrowHeight, rect.y());
    QPoint topRight(rect.x() + rect.width(), rect.y());
    QPoint bottomRight(rect.x() + rect.width(), rect.y() + rect.height());
    QPoint bottomLeft(rect.x() + arrowHeight, rect.y() + rect.height());
    int radius = this->radius > (rect.height() / 2) ? rect.height() / 2 : this->radius;

    QPainterPath border;
    border.moveTo(topLeft);
    border.lineTo(topRight.x() - radius, topRight.y());
    border.arcTo(topRight.x() - 2 * radius, topRight.y(), 2 * radius, 2 * radius, 90, -90);
    border.lineTo(bottomRight.x(), bottomRight.y() - radius);
    border.arcTo(bottomRight.x() - 2 * radius, bottomRight.y() - 2 * radius, 2 * radius, 2 * radius, 0, -90);
    border.lineTo(bottomLeft);
    border.lineTo(cornerPoint);
    border.lineTo(topLeft);

    return border;
}

QPainterPath DSingleLineTip::getRightCornerPath()
{
    QRect rect = this->rect().marginsRemoved(QMargins(shadowWidth,shadowWidth,shadowWidth,shadowWidth));

    QPoint cornerPoint(rect.x() + rect.width(), rect.y() + rect.height() / 2);
    QPoint topLeft(rect.x(), rect.y());
    QPoint topRight(rect.x() + rect.width() - arrowHeight, rect.y());
    QPoint bottomRight(rect.x() + rect.width() - arrowHeight, rect.y() + rect.height());
    QPoint bottomLeft(rect.x(), rect.y() + rect.height());
    int radius = this->radius > (rect.height() / 2) ? rect.height() / 2 : this->radius;

    QPainterPath border;
    border.moveTo(topLeft.x() + radius, topLeft.y());
    border.lineTo(topRight);
    border.lineTo(cornerPoint);
    border.lineTo(bottomRight);
    border.lineTo(bottomLeft.x() + radius, bottomLeft.y());
    border.arcTo(bottomLeft.x(), bottomLeft.y() - 2 * radius, 2 * radius, 2 * radius, -90, -90);
    border.lineTo(topLeft.x(), topLeft.y() + radius);
    border.arcTo(topLeft.x(), topLeft.y(), 2 * radius, 2 * radius, 180, -90);

    return border;
}

QPainterPath DSingleLineTip::getTopCornerPath()
{
    QRect rect = this->rect().marginsRemoved(QMargins(shadowWidth,shadowWidth,shadowWidth,shadowWidth));

    QPoint cornerPoint(rect.x() + arrowLeftMargin, rect.y());
    QPoint topLeft(rect.x(), rect.y() + arrowHeight);
    QPoint topRight(rect.x() + rect.width(), rect.y() + arrowHeight);
    QPoint bottomRight(rect.x() + rect.width(), rect.y() + rect.height());
    QPoint bottomLeft(rect.x(), rect.y() + rect.height());
    int radius = this->radius > (rect.height() / 2 - arrowHeight) ? rect.height() / 2 -arrowHeight : this->radius;

    QPainterPath border;
    border.moveTo(topLeft.x() + radius, topLeft.y());
    border.lineTo(cornerPoint.x() - arrowWidth / 2, cornerPoint.y() + arrowHeight);
    border.lineTo(cornerPoint);
    border.lineTo(cornerPoint.x() + arrowWidth / 2, cornerPoint.y() + arrowHeight);
    border.lineTo(topRight.x() - radius, topRight.y());
    border.arcTo(topRight.x() - 2 * radius, topRight.y(), 2 * radius, 2 * radius, 90, -90);
    border.lineTo(bottomRight.x(), bottomRight.y() - radius);
    border.arcTo(bottomRight.x() - 2 * radius, bottomRight.y() - 2 * radius, 2 * radius, 2 * radius, 0, -90);
    border.lineTo(bottomLeft.x() + radius, bottomLeft.y());
    border.arcTo(bottomLeft.x(), bottomLeft.y() - 2 * radius, 2 * radius, 2 * radius, - 90, -90);
    border.lineTo(topLeft.x(), topLeft.y() + radius);
    border.arcTo(topLeft.x(), topLeft.y(), 2 * radius, 2 * radius, 180, -90);

    return border;
}

QPainterPath DSingleLineTip::getBottomCornerPath()
{
    QRect rect = this->rect().marginsRemoved(QMargins(shadowWidth,shadowWidth,shadowWidth,shadowWidth));

    QPoint cornerPoint(rect.x() + arrowLeftMargin, rect.y()  + rect.height());
    QPoint topLeft(rect.x(), rect.y());
    QPoint topRight(rect.x() + rect.width(), rect.y());
    QPoint bottomRight(rect.x() + rect.width(), rect.y() + rect.height() - arrowHeight);
    QPoint bottomLeft(rect.x(), rect.y() + rect.height() - arrowHeight);
    int radius = this->radius > (rect.height() / 2 - arrowHeight) ? rect.height() / 2 -arrowHeight : this->radius;

    QPainterPath border;
    border.moveTo(topLeft.x() + radius, topLeft.y());
    border.lineTo(topRight.x() - radius, topRight.y());
    border.arcTo(topRight.x() - 2 * radius, topRight.y(), 2 * radius, 2 * radius, 90, -90);
    border.lineTo(bottomRight.x(), bottomRight.y() - radius);
    border.arcTo(bottomRight.x() - 2 * radius, bottomRight.y() - 2 * radius, 2 * radius, 2 * radius, 0, -90);
    border.lineTo(cornerPoint.x() + arrowWidth / 2, cornerPoint.y() - arrowHeight);
    border.lineTo(cornerPoint);
    border.lineTo(cornerPoint.x() - arrowWidth / 2, cornerPoint.y() - arrowHeight);
    border.lineTo(bottomLeft.x() + radius, bottomLeft.y());
    border.arcTo(bottomLeft.x(), bottomLeft.y() - 2 * radius, 2 * radius, 2 * radius, -90, -90);
    border.lineTo(topLeft.x(), topLeft.y() + radius);
    border.arcTo(topLeft.x(), topLeft.y(), 2 * radius, 2 * radius, 180, -90);

    return border;
}

DSingleLineTip::~DSingleLineTip()
{

}



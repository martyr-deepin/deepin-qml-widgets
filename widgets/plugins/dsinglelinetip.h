#ifndef DSINGLELINETIP_H
#define DSINGLELINETIP_H

#include <QWidget>
#include <QLabel>
#include <QTextLine>
#include <QHBoxLayout>
#include <QVBoxLayout>
#include <QPainter>
#include <QTimer>
#include <QGraphicsEffect>

class DSingleLineTip : public QWidget
{
    Q_OBJECT
public:
    explicit DSingleLineTip(QWidget * parent = 0);
    ~DSingleLineTip();

    Q_PROPERTY(int x READ getX WRITE setX NOTIFY xChanged)
    Q_PROPERTY(int y READ getY WRITE setY NOTIFY yChanged)
    Q_PROPERTY(int width READ getWidth WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ getHeight WRITE setHeight NOTIFY heightChanged)
    Q_PROPERTY(int radius READ getRadius WRITE setRadius NOTIFY radiusChanged)
    Q_PROPERTY(int borderWidth READ getBorderWidth WRITE setBorderWidth NOTIFY borderWidthChanged)
    Q_PROPERTY(int arrowHeight READ getArrowHeight WRITE setArrowHeight NOTIFY arrowHeightChanged)
    Q_PROPERTY(int arrowWidth READ getArrowWidth WRITE setArrowWidth NOTIFY arrowWidthChanged)
    Q_PROPERTY(int arrowLeftMargin READ getArrowLeftMargin WRITE setArrowLeftMargin NOTIFY arrowLeftMarginChanged)
    Q_PROPERTY(int destroyInterval READ getDestroyInterval WRITE setDestroyInterval NOTIFY destroyIntervalChanged)
    Q_PROPERTY(int fontPixelSize READ getFontPixelSize WRITE setFontPixelSize NOTIFY fontPixelSizeChanged)
    Q_PROPERTY(int shadowWidth READ getShadowWidth WRITE setShadowWidth NOTIFY shadowWidthChanged)
    Q_PROPERTY(QString shadowColor READ getShadowColor WRITE setShadowColor NOTIFY shadowColorChanged)
    Q_PROPERTY(QString borderColor READ getBorderColor WRITE setBorderColor NOTIFY borderColorChanged)
    Q_PROPERTY(QColor backgroundColor READ getBackgroundColor WRITE setBackgroundColor NOTIFY backgroundColorChanged)
    Q_PROPERTY(QString textColor READ getTextColor WRITE setTextColor NOTIFY textColorChanged)
    Q_PROPERTY(QString toolTip READ getToolTip WRITE setToolTip NOTIFY toolTipChanged)

    int getX();
    int getY();
    int getWidth();
    int getHeight();
    int getRadius();
    int getArrowHeight();
    int getArrowWidth();
    int getArrowLeftMargin();
    int getDestroyInterval();
    int getBorderWidth();
    int getFontPixelSize();
    int getShadowWidth();
    QString getShadowColor();
    QString getBorderColor();
    QColor getBackgroundColor();
    QString getTextColor();
    QString getToolTip();

    void setX(int value);
    void setY(int value);
    void setWidth(int value);
    void setHeight(int value);
    void setRadius(int value);
    void setArrowHeight(int value);
    void setArrowWidth(int value);
    void setArrowLeftMargin(int value);
    void setDestroyInterval(int value);
    void setBorderWidth(int value);
    void setFontPixelSize(int value);
    void setShadowWidth(int value);
    void setShadowColor(QString value);
    void setBorderColor(QString value);
    void setBackgroundColor(QColor value);
    void setTextColor(QString value);
    void setToolTip(QString value);

    Q_INVOKABLE void showTip();
    Q_INVOKABLE void showTipAtLeft();
    Q_INVOKABLE void showTipAtRight();
    Q_INVOKABLE void showTipAtTop();
    Q_INVOKABLE void showTipAtBottom();

    Q_INVOKABLE void destroyTip();

protected:
    virtual void paintEvent(QPaintEvent *);

signals:
    void xChanged();
    void yChanged();
    void widthChanged();
    void heightChanged();
    void radiusChanged();
    void arrowHeightChanged();
    void arrowWidthChanged();
    void arrowLeftMarginChanged();
    void destroyIntervalChanged();
    void fontPixelSizeChanged();
    void shadowWidthChanged();
    void shadowColorChanged();
    void borderWidthChanged();
    void borderColorChanged();
    void backgroundColorChanged();
    void textColorChanged();
    void toolTipChanged();

private:
    enum ArrowDirection {
        arrowLeft,
        arrowRight,
        arrowTop,
        arrowBottom
    };

    int x;
    int y;
    int width;
    int height;
    int radius = 1;
    int arrowHeight = 8;
    int arrowWidth = 20;
    int arrowLeftMargin = 20;
    int destroyInterval = -1;
    QColor backgroundColor;
    QString textColor;
    QString toolTip;

    int fontPixelSize = 14;
    int borderWidth = 2;
    QColor borderColor = Qt::white;
    int shadowWidth = 2;
    QColor shadowColor = Qt::black;

    ArrowDirection arrowDirection = DSingleLineTip::arrowRight;

    QLabel * m_tipLabel;
    QTimer * m_destroyTimer;

private:
    QPainterPath getLeftCornerPath();
    QPainterPath getRightCornerPath();
    QPainterPath getTopCornerPath();
    QPainterPath getBottomCornerPath();

};

#endif // DSINGLELINETIP_H

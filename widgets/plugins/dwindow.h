#ifndef DWINDOW_H
#define DWINDOW_H

#include <QQuickItem>
#include <QQuickWindow>

#include <xcb/xcb.h>
#include <xcb/xproto.h>

class DWindow;
class DOverrideWindow;

class DWindow: public QQuickWindow
{
    Q_OBJECT
    Q_DISABLE_COPY(DWindow)

public:
    DWindow(QQuickWindow *parent = 0);
    ~DWindow();

    Q_PROPERTY(int shadowWidth READ shadowWidth WRITE setShadowWidth NOTIFY shadowWidthChanged)

    Q_INVOKABLE QPoint getCursorPos();
    Q_INVOKABLE int getWinId();

    int shadowWidth();
    void setShadowWidth(int);

public slots:
    void focusChanged(QWindow * win);

signals:
    void shadowWidthChanged(int shadowWidth);
    void windowFocusChanged(QWindow *window);
    void mousePressed(QPointF point);
    void wheel(QPointF point);

protected:
    virtual void mousePressEvent(QMouseEvent *ev);
    virtual void wheelEvent(QWheelEvent *ev);

private:
    int _shadowWidth;

    xcb_connection_t *_conn;

private slots:
    void visibilityChangedSlot(QWindow::Visibility);
};

class DOverrideWindow: public DWindow
{
    Q_OBJECT
    Q_DISABLE_COPY(DOverrideWindow)

public:
    DOverrideWindow(DWindow *parent = 0);
    ~DOverrideWindow();

};


#endif // DWINDOW_H

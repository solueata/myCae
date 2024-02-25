#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include "QVTKOpenGLNativeWidget.h"

class Widget : public QWidget
{
    Q_OBJECT

public:
    Widget(QWidget *parent = nullptr);
    ~Widget();
private:
    QVTKOpenGLNativeWidget* my_qvtkWidget;
};

#endif // WIDGET_H

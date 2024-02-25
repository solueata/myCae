#include "gmsh.h"
#include "widget.h"
#include <QApplication>
#include <vtkAutoInit.h>

VTK_MODULE_INIT(vtkRenderingOpenGL2);
VTK_MODULE_INIT(vtkInteractionStyle);

int main(int argc, char *argv[])
{
    gmsh::initialize(argc, argv);
    QApplication a(argc, argv);
    Widget w;
    w.resize(1000,800);
    w.show();
    return a.exec();
}

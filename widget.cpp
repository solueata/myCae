#include "widget.h"
#include "vtkGenericOpenGLRenderWindow.h"
#include <QGridLayout>
#include <StlAPI_Reader.hxx>
#include <BRep_Builder.hxx>
#include <StlAPI.hxx>
#include <TopTools_HSequenceOfShape.hxx>
#include <AIS_Shape.hxx>
#include <BRepBuilderAPI_MakeShell.hxx>
#include <BRepBuilderAPI_MakeWire.hxx>
#include <BRepBuilderAPI_MakeEdge.hxx>
#include <BRepBuilderAPI_MakeFace.hxx>
#include <TopExp_Explorer.hxx>
#include <vtkRenderWindow.h>
#include <vtkSmartPointer.h>
#include <vtkRenderer.h>
#include <vtkAppendPolyData.h>
#include <IVtkOCC_Shape.hxx>
#include <IVtkTools_ShapeDataSource.hxx>
#include <vtkCleanPolyData.h>
#include <vtkPoints.h>
#include <vtkCell.h>
#include <vtkIdList.h>
#include <vtkTriangle.h>
#include <vtkPolyDataNormals.h>
#include <vtkPolyData.h>
#include <vtkPolyDataMapper.h>
#include <gp_Pnt.hxx>
#include <gp_Dir.hxx>
#include <GC_MakePlane.hxx>
#include <BRepTools.hxx>
#include "gmsh.h"
#include <QDebug>

Widget::Widget(QWidget *parent)
    : QWidget(parent)
{
    //初始化VTK窗口，命名为qvtkWidget（原理和QPushButton这种QT自带的控件一样，只是该控件由VTK提供，用法跟QPushButton是一样的）
    my_qvtkWidget = new QVTKOpenGLNativeWidget();
    //初始化VTK的渲染器，平时用的比较多是vtkRenderWindow，但是在QT中要改用vtkGenericOpenGLRenderWindow，实质上与vtkRenderWindow功能一致
    vtkGenericOpenGLRenderWindow* renderWindow = vtkGenericOpenGLRenderWindow::New();
    //将渲染器加入到VTK窗口中。可以先写这一行，后续再将准备好的vtkRenderer加入到renderWindow中也是可以同步数据的
    my_qvtkWidget->setRenderWindow(renderWindow);
    //创建网格布局，只是为了方便布局，实际上可以直接调用qvtkwidget的baseSize函数指定窗口大小也行
    QGridLayout* displayGrid = new QGridLayout(this);
    displayGrid->addWidget(my_qvtkWidget);
    this->setLayout(displayGrid);

//    QString fileName = "C:/Users/solue/Desktop/Unnamed-Sketch.stl";
//    std::string str = fileName.toStdString();
//    const char* c_fn = str.c_str();
//    StlAPI_Reader r_stl;
//    TopoDS_Shape shape;
//    r_stl.Read(shape, c_fn);
//    TopTools_HSequenceOfShape* sequ = new TopTools_HSequenceOfShape;
//    sequ->Append(shape);
//    Standard_Integer index = sequ->Length();
//    TopoDS_Shape comp = sequ->ChangeValue(index);
//    TopoDS_Shape* fshape = new TopoDS_Shape;
//    *fshape = comp;

//    gp_Dir dir1(0,0,1);
//    gp_Pnt pt1(0,0,0);
//    GC_MakePlane plane(pt1,dir1);
//    BRepBuilderAPI_MakeShell shell(plane.Value(),0,10,0,10);
//    TopoDS_Shape shape = shell.Shape();
//    BRepTools::Write(shape,"shell_test.brep");

    gp_Pnt pt1(0,0,0);
    gp_Pnt pt2(10,0,0);
    gp_Pnt pt3(10,10,0);
    gp_Pnt pt4(0,10,0);

    BRepBuilderAPI_MakeEdge edge1(pt1,pt2);
    BRepBuilderAPI_MakeEdge edge2(pt2,pt3);
    BRepBuilderAPI_MakeEdge edge3(pt3,pt4);
    BRepBuilderAPI_MakeEdge edge4(pt4,pt1);


    BRepBuilderAPI_MakeWire wire1(edge1.Edge(),edge2.Edge(),edge3.Edge(),edge4.Edge());
    BRepBuilderAPI_MakeFace face1(wire1);
    BRepTools::Write(face1.Shape(),"face_test.brep");

    TopoDS_Shape faces = face1.Shape();

    gmsh::clear();
    gmsh::model::add("test1");
    gmsh::vectorpair outDimTags;
    gmsh::option::setNumber("Mesh.CharacteristicLengthFactor", 1);
    //gmsh::option::setNumber("Mesh.Algorithm", 8);
    //gmsh::option::setNumber("Mesh.RecombineAll", 1);
    //gmsh::option::setNumber("Mesh.SubdivisionAlgorithm", 2);
    gmsh::model::occ::importShapes("C:/work/myCad/build/420maopi1.stp", outDimTags,false);
    gmsh::model::occ::synchronize();
//  gmsh::model::occ::importShapesNativePointer(&faces,outDimTags);
//  qDebug() << outDimTags.at(0).first << outDimTags.at(0).second;
//    gmsh::open("C:/work/myCad/build/test.geo");
    //if(1) {
    //    int NN = 30;
    //    std::vector<std::pair<int, int> > tmp;
    //    gmsh::model::getEntities(tmp, 1);
    //    for (auto c : tmp) { gmsh::model::mesh::setTransfiniteCurve(c.second, NN); }
    //    gmsh::model::getEntities(tmp, 2);
    //    for (auto s : tmp) {
    //        gmsh::model::mesh::setTransfiniteSurface(s.second);
    //        gmsh::model::mesh::setRecombine(s.first, s.second);
    //        gmsh::model::mesh::setSmoothing(s.first, s.second, 100);
    //    }
    //    gmsh::model::mesh::setTransfiniteVolume(1);
    //}
    gmsh::model::mesh::generate(3);
    std::vector<int> elementTypes;
    std::vector<std::vector<std::size_t> > elementTags;
    std::vector<std::vector<std::size_t> > nodeTags;
    gmsh::model::mesh::getElements(elementTypes,elementTags,nodeTags,2,1);
    //std::vector<double> layers = {1,1,1,1,1,1,1,1,1,1};
    //gmsh::model::geo::extrude(outDimTags,0,0,1,outDimTags,elementTypes,layers,true);
    //gmsh::write("C:/work/myCad/build/test.inp");

    gmsh::finalize();

    for(int i=0;i<elementTypes.size();i++)
    {
        qDebug() << elementTypes.at(i) << nodeTags.at(i).at(0) << nodeTags.at(i).at(0) << nodeTags.at(i).at(0);
    }

    vtkSmartPointer<vtkRenderWindow> renderWindow2 = my_qvtkWidget->renderWindow();
    vtkNew<vtkRenderer> render;
    renderWindow2->AddRenderer(render);


//    TopExp_Explorer solidExp(comp,TopAbs_SOLID);
//    for(int index=0; solidExp.More(); solidExp.Next(), ++index)
//    {
//        QList<Handle(TopoDS_TShape)> tshapeList;
//        const TopoDS_Shape& solid = solidExp.Current();
//        TopExp_Explorer faceExp(solid,TopAbs_FACE);

//        vtkSmartPointer<vtkAppendPolyData> appendFilter =  vtkSmartPointer<vtkAppendPolyData>::New();
//        vtkPolyData* polyData = vtkPolyData::New();
//        for(int i=0; faceExp.More(); faceExp.Next(), i++)
//        {
//            const TopoDS_Shape& face = faceExp.Current();
//            Handle(TopoDS_TShape) tface = face.TShape();
//            if(tshapeList.contains(tface)) continue;//共享面只
//            tshapeList.append(tface);

//            IVtkOCC_Shape::Handle ShapeImpl = new IVtkOCC_Shape(face);
//            vtkSmartPointer<IVtkTools_ShapeDataSource> DS = vtkSmartPointer<IVtkTools_ShapeDataSource>::New();
//            DS->SetShape(ShapeImpl);

//            vtkSmartPointer<vtkCleanPolyData> cleanFilter = vtkSmartPointer<vtkCleanPolyData>::New();
//            cleanFilter->SetInputConnection(DS->GetOutputPort());
//            cleanFilter->Update();

//            vtkSmartPointer<vtkPolyData> tpolys = vtkSmartPointer<vtkPolyData>::New();
//            vtkPolyData* tpolydata = cleanFilter->GetOutput();
//            const int np = tpolydata->GetNumberOfPoints();
//            const int nc = tpolydata->GetNumberOfCells();
//            vtkPoints* points = vtkPoints::New();
//            for(int i=0; i<np; i++)
//            {
//                double* coor = tpolydata->GetPoint(i);
//                points->InsertNextPoint(coor);
//            }

//            tpolys->SetPoints(points);

//            vtkCellArray* cells = vtkCellArray::New();
//            for(int i=0; i<nc; i++)
//            {
//                vtkCell* cell = tpolydata->GetCell(i);
//                vtkIdList* ceid = cell->GetPointIds();
//                if(ceid->GetNumberOfIds() == 3)
//                {
//                    vtkTriangle* triangle = vtkTriangle::New();
//                    triangle->DeepCopy(cell);
//                    cells->InsertNextCell(triangle);
//                }
//                tpolys->SetPolys(cells);

//                vtkSmartPointer<vtkPolyDataNormals> normals = vtkSmartPointer<vtkPolyDataNormals>::New();
//                normals->SetInputData(tpolys);
//                normals->FlipNormalsOn();
//                normals->Update();

//                vtkPolyData* facePoly = normals->GetOutput();
//                const int ncell = facePoly->GetNumberOfCells();
//                if(ncell < 1) continue;

//                appendFilter->AddInputData(facePoly);
//            }
//        }
//        appendFilter->Update();
//        polyData->DeepCopy(appendFilter->GetOutput());

//        vtkSmartPointer<vtkPolyDataMapper> mapper = vtkSmartPointer<vtkPolyDataMapper>::New();
//        mapper->SetInputData(polyData);
//        vtkSmartPointer<vtkActor> actor = vtkSmartPointer<vtkActor>::New();
//        actor->SetMapper(mapper);
//        render->AddActor(actor);
//        render->ResetCamera();
//        render->SetBackground(0,0,0);
//    }

//    renderWindow2->Render();
}

Widget::~Widget()
{
    delete my_qvtkWidget;
}

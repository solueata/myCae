#ifndef INPREADER_H
#define INPREADER_H

#include <QString>
#include <vtkPolyData.h>
#include <QMap>

class vtkPoints;
class vtkCellArray;

class INPReader
{
public:
    INPReader();
    bool readFile(QString path);
    void readNodes(QString lineStr,vtkPoints* points);
    //vktpolyData* readLine(QString lineStr, vtkPoint)
    QString convertType(QString type);
private:
    vtkPolyData* m_meshNodes;
    vtkPolyData* m_meshSolid;
    QMap<QString,QString> typeMap;
};

#endif // INPREADER_H

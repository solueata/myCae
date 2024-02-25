#include "inpreader.h"
#include "vtkPoints.h"
#include "vtkCellArray.h"

#include <QFile>

INPReader::INPReader()
{
    QFile file("");
    if (file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        while(!file.atEnd())
        {
            QByteArray line = file.readLine();
            QString lineStr(line);
            QStringList types = lineStr.split(":");
            typeMap.insert(types[0],types[1]);
        }
    }
}

bool INPReader::readFile(QString path)
{
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return false;
    vtkPoints* NodePoints = vtkPoints::New();
    vtkPoints* SetPoints = vtkPoints::New();
    vtkCellArray* cells = vtkCellArray::New();
    while (!file.atEnd()) {
        QByteArray line = file.readLine();
        QString lineStr(line);
        if(lineStr.startsWith("**"))
            continue;
        QStringList keys = lineStr.split(",");
        QString keyWord = keys[0].replace("*","");
        if(keyWord == "NODE")
        {
            QString str(file.readLine());
            readNodes(str,NodePoints);//最终存放到meshNodes中
        }
        else if(keyWord == "ELEMENT")
        {
            QString type = keys[1].split("=")[1];
            QString SetType = keys[2].split("=")[1];
            if(SetType.startsWith("Line"))
            {

            }
        }
        else if(keyWord == "INCLUDE")
        {

        }
    }
    return false;
}

void INPReader::readNodes(QString lineStr, vtkPoints *points)
{

}

QString INPReader::convertType(QString type)
{
    return typeMap.value(type);
}

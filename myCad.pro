#-------------------------------------------------
#
# Project created by QtCreator 2023-04-03T09:17:23
#
#-------------------------------------------------

QT       += core gui opengl

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = myCad
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

CONFIG += c++11

QMAKE_CXXFLAGS_RELEASE = $$QMAKE_CFLAGS_RELEASE_WITH_DEBUGINFO
QMAKE_LFLAGS_RELEASE = $$QMAKE_LFLAGS_RELEASE_WITH_DEBUGINFO

INCLUDEPATH += $$PWD/gmsh_api/include

SOURCES += \
        inpreader.cpp \
        main.cpp \
        widget.cpp

HEADERS += \
        inpreader.h \
        widget.h

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

OCCROOT = "C:/OpenCASCADE-7.4.0-vc14-64/opencascade-7.4.0"
OCCLIB = "C:/OpenCASCADE-7.4.0-vc14-64/opencascade-7.4.0/win64/vc14/lib"
VTKINC = "C:/Program Files (x86)/VTK//include/vtk-9.2"
VTKLIB = "C:/Program Files (x86)/VTK/lib"
GMSHLIB = "$$PWD/build"
message($$GMSHLIB)

win32 {
    DEFINES +=  \
        WNT
    INCLUDEPATH +=  \
        $$OCCROOT/inc \
        $$VTKINC

    DESTDIR = $$PWD/build

    win32-msvc2010 {
        compiler=vc10
    }

    win32-msvc2012 {
        compiler=vc11
    }

    win32-msvc2013 {
        compiler=vc12
    }

    win32-msvc2015 {
        compiler=vc14
    }

    # Determine 32 / 64 bit and debug / release build
    !contains(QMAKE_TARGET.arch, x86_64) {
        CONFIG(debug, debug|release) {
            message("Debug 32 build")
            LIBS += -L$$OCCROOT/win32/$$compiler/libd
        }
        else {
            message("Release 32 build")
            LIBS += -L$$OCCROOT/win32/$$compiler/lib
        }
    }
    else {
        CONFIG(debug, debug|release) {
            message("Debug 64 build")
            LIBS += -L$$CASROOT/win64/$$compiler/libd
        }
        else {
            message("Release 64 build")
            LIBS += -L$$CASROOT/win64/$$compiler/lib
        }
    }
}

LIBS +=         \
    -L$$OCCLIB -lTKernel   \
    -L$$OCCLIB -lTKMath    \
    -L$$OCCLIB -lTKG3d     \
    -L$$OCCLIB -lTKBRep    \
    -L$$OCCLIB -lTKGeomBase\
    -L$$OCCLIB -lTKGeomAlgo\
    -L$$OCCLIB -lTKTopAlgo \
    -L$$OCCLIB -lTKPrim    \
    -L$$OCCLIB -lTKBO      \
    -L$$OCCLIB -lTKBool    \
    -L$$OCCLIB -lTKOffset  \
    -L$$OCCLIB -lTKService \
    -L$$OCCLIB -lTKV3d     \
    -L$$OCCLIB -lTKOpenGl  \
    -L$$OCCLIB -lTKFillet  \
    -L$$OCCLIB -lTKSTL \
    -L$$OCCLIB -lTKIVtk \
    -L$$VTKLIB -lvtkRenderingVtkJS-9.2 \
    -L$$VTKLIB -lvtkChartsCore-9.2 \
    -L$$VTKLIB -lvtkCommonColor-9.2 \
    -L$$VTKLIB -lvtkCommonComputationalGeometry-9.2 \
    -L$$VTKLIB -lvtkCommonCore-9.2 \
    -L$$VTKLIB -lvtkCommonDataModel-9.2 \
    -L$$VTKLIB -lvtkCommonExecutionModel-9.2 \
    -L$$VTKLIB -lvtkCommonMath-9.2 \
    -L$$VTKLIB -lvtkCommonMisc-9.2 \
    -L$$VTKLIB -lvtkCommonSystem-9.2 \
    -L$$VTKLIB -lvtkCommonTransforms-9.2 \
    -L$$VTKLIB -lvtkDICOMParser-9.2 \
    -L$$VTKLIB -lvtkDomainsChemistry-9.2 \
    -L$$VTKLIB -lvtkDomainsChemistryOpenGL2-9.2 \
    -L$$VTKLIB -lvtkFiltersAMR-9.2 \
    -L$$VTKLIB -lvtkFiltersCore-9.2 \
    -L$$VTKLIB -lvtkFiltersExtraction-9.2 \
    -L$$VTKLIB -lvtkFiltersFlowPaths-9.2 \
    -L$$VTKLIB -lvtkFiltersGeneral-9.2 \
    -L$$VTKLIB -lvtkFiltersGeneric-9.2 \
    -L$$VTKLIB -lvtkFiltersGeometry-9.2 \
    -L$$VTKLIB -lvtkFiltersHybrid-9.2 \
    -L$$VTKLIB -lvtkFiltersHyperTree-9.2 \
    -L$$VTKLIB -lvtkFiltersImaging-9.2 \
    -L$$VTKLIB -lvtkFiltersModeling-9.2 \
    -L$$VTKLIB -lvtkFiltersParallel-9.2 \
    -L$$VTKLIB -lvtkFiltersParallelImaging-9.2 \
    -L$$VTKLIB -lvtkFiltersPoints-9.2 \
    -L$$VTKLIB -lvtkFiltersProgrammable-9.2 \
    -L$$VTKLIB -lvtkFiltersSMP-9.2 \
    -L$$VTKLIB -lvtkFiltersSelection-9.2 \
    -L$$VTKLIB -lvtkFiltersSources-9.2 \
    -L$$VTKLIB -lvtkFiltersStatistics-9.2 \
    -L$$VTKLIB -lvtkFiltersTexture-9.2 \
    -L$$VTKLIB -lvtkFiltersTopology-9.2 \
    -L$$VTKLIB -lvtkFiltersVerdict-9.2 \
    -L$$VTKLIB -lvtkGUISupportQt-9.2 \
    -L$$VTKLIB -lvtkGUISupportQtQuick-9.2 \
    -L$$VTKLIB -lvtkGUISupportQtSQL-9.2 \
    -L$$VTKLIB -lvtkGeovisCore-9.2 \
    -L$$VTKLIB -lvtkIOAMR-9.2 \
    -L$$VTKLIB -lvtkIOAsynchronous-9.2 \
    -L$$VTKLIB -lvtkIOCGNSReader-9.2 \
    -L$$VTKLIB -lvtkIOCONVERGECFD-9.2 \
    -L$$VTKLIB -lvtkIOCesium3DTiles-9.2 \
    -L$$VTKLIB -lvtkIOChemistry-9.2 \
    -L$$VTKLIB -lvtkIOCityGML-9.2 \
    -L$$VTKLIB -lvtkIOCore-9.2 \
    -L$$VTKLIB -lvtkIOEnSight-9.2 \
    -L$$VTKLIB -lvtkIOExodus-9.2 \
    -L$$VTKLIB -lvtkIOExport-9.2 \
    -L$$VTKLIB -lvtkIOExportGL2PS-9.2 \
    -L$$VTKLIB -lvtkIOExportPDF-9.2 \
    -L$$VTKLIB -lvtkIOGeometry-9.2 \
    -L$$VTKLIB -lvtkIOHDF-9.2 \
    -L$$VTKLIB -lvtkIOIOSS-9.2 \
    -L$$VTKLIB -lvtkIOImage-9.2 \
    -L$$VTKLIB -lvtkIOImport-9.2 \
    -L$$VTKLIB -lvtkIOInfovis-9.2 \
    -L$$VTKLIB -lvtkIOLSDyna-9.2 \
    -L$$VTKLIB -lvtkIOLegacy-9.2 \
    -L$$VTKLIB -lvtkIOMINC-9.2 \
    -L$$VTKLIB -lvtkIOMotionFX-9.2 \
    -L$$VTKLIB -lvtkIOMovie-9.2 \
    -L$$VTKLIB -lvtkIONetCDF-9.2 \
    -L$$VTKLIB -lvtkIOOggTheora-9.2 \
    -L$$VTKLIB -lvtkIOPLY-9.2 \
    -L$$VTKLIB -lvtkIOParallel-9.2 \
    -L$$VTKLIB -lvtkIOParallelXML-9.2 \
    -L$$VTKLIB -lvtkIOSQL-9.2 \
    -L$$VTKLIB -lvtkIOSegY-9.2 \
    -L$$VTKLIB -lvtkIOTecplotTable-9.2 \
    -L$$VTKLIB -lvtkIOVeraOut-9.2 \
    -L$$VTKLIB -lvtkIOVideo-9.2 \
    -L$$VTKLIB -lvtkIOXML-9.2 \
    -L$$VTKLIB -lvtkIOXMLParser-9.2 \
    -L$$VTKLIB -lvtkImagingColor-9.2 \
    -L$$VTKLIB -lvtkImagingCore-9.2 \
    -L$$VTKLIB -lvtkImagingFourier-9.2 \
    -L$$VTKLIB -lvtkImagingGeneral-9.2 \
    -L$$VTKLIB -lvtkImagingHybrid-9.2 \
    -L$$VTKLIB -lvtkImagingMath-9.2 \
    -L$$VTKLIB -lvtkImagingMorphological-9.2 \
    -L$$VTKLIB -lvtkImagingSources-9.2 \
    -L$$VTKLIB -lvtkImagingStatistics-9.2 \
    -L$$VTKLIB -lvtkImagingStencil-9.2 \
    -L$$VTKLIB -lvtkInfovisCore-9.2 \
    -L$$VTKLIB -lvtkInfovisLayout-9.2 \
    -L$$VTKLIB -lvtkInteractionImage-9.2 \
    -L$$VTKLIB -lvtkInteractionStyle-9.2 \
    -L$$VTKLIB -lvtkInteractionWidgets-9.2 \
    -L$$VTKLIB -lvtkParallelCore-9.2 \
    -L$$VTKLIB -lvtkParallelDIY-9.2 \
    -L$$VTKLIB -lvtkRenderingAnnotation-9.2 \
    -L$$VTKLIB -lvtkRenderingContext2D-9.2 \
    -L$$VTKLIB -lvtkRenderingContextOpenGL2-9.2 \
    -L$$VTKLIB -lvtkRenderingCore-9.2 \
    -L$$VTKLIB -lvtkRenderingFreeType-9.2 \
    -L$$VTKLIB -lvtkRenderingGL2PSOpenGL2-9.2 \
    -L$$VTKLIB -lvtkRenderingHyperTreeGrid-9.2 \
    -L$$VTKLIB -lvtkRenderingImage-9.2 \
    -L$$VTKLIB -lvtkRenderingLICOpenGL2-9.2 \
    -L$$VTKLIB -lvtkRenderingLOD-9.2 \
    -L$$VTKLIB -lvtkRenderingLabel-9.2 \
    -L$$VTKLIB -lvtkRenderingOpenGL2-9.2 \
    -L$$VTKLIB -lvtkRenderingQt-9.2 \
    -L$$VTKLIB -lvtkRenderingSceneGraph-9.2 \
    -L$$VTKLIB -lvtkRenderingUI-9.2 \
    -L$$VTKLIB -lvtkRenderingVolume-9.2 \
    -L$$VTKLIB -lvtkRenderingVolumeOpenGL2-9.2 \
    -L$$VTKLIB -lvtkTestingRendering-9.2 \
    -L$$VTKLIB -lvtkViewsContext2D-9.2 \
    -L$$VTKLIB -lvtkViewsCore-9.2 \
    -L$$VTKLIB -lvtkViewsInfovis-9.2 \
    -L$$VTKLIB -lvtkViewsQt-9.2 \
    -L$$VTKLIB -lvtkWrappingTools-9.2 \
    -L$$VTKLIB -lvtkcgns-9.2 \
    -L$$VTKLIB -lvtkdoubleconversion-9.2 \
    -L$$VTKLIB -lvtkexodusII-9.2 \
    -L$$VTKLIB -lvtkexpat-9.2 \
    -L$$VTKLIB -lvtkfmt-9.2 \
    -L$$VTKLIB -lvtkfreetype-9.2 \
    -L$$VTKLIB -lvtkgl2ps-9.2 \
    -L$$VTKLIB -lvtkglew-9.2 \
    -L$$VTKLIB -lvtkhdf5-9.2 \
    -L$$VTKLIB -lvtkhdf5_hl-9.2 \
    -L$$VTKLIB -lvtkioss-9.2 \
    -L$$VTKLIB -lvtkjpeg-9.2 \
    -L$$VTKLIB -lvtkjsoncpp-9.2 \
    -L$$VTKLIB -lvtkkissfft-9.2 \
    -L$$VTKLIB -lvtklibharu-9.2 \
    -L$$VTKLIB -lvtklibproj-9.2 \
    -L$$VTKLIB -lvtklibxml2-9.2 \
    -L$$VTKLIB -lvtkloguru-9.2 \
    -L$$VTKLIB -lvtklz4-9.2 \
    -L$$VTKLIB -lvtklzma-9.2 \
    -L$$VTKLIB -lvtkmetaio-9.2 \
    -L$$VTKLIB -lvtknetcdf-9.2 \
    -L$$VTKLIB -lvtkogg-9.2 \
    -L$$VTKLIB -lvtkpng-9.2 \
    -L$$VTKLIB -lvtkpugixml-9.2 \
    -L$$VTKLIB -lvtksqlite-9.2 \
    -L$$VTKLIB -lvtksys-9.2 \
    -L$$VTKLIB -lvtktheora-9.2 \
    -L$$VTKLIB -lvtktiff-9.2 \
    -L$$VTKLIB -lvtkverdict-9.2 \
    -L$$VTKLIB -lvtkzlib-9.2 \
    -L$$GMSHLIB -lgmsh

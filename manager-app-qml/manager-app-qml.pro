QT += quick sql websockets charts

CONFIG += c++11

SOURCES += \
        ../customer-app-qml/ProductListModel.cpp \
        ../data/Category.cpp \
        ../data/Product.cpp \
        ../data/ProductionDatabase.cpp \
        ../data/ProductsDao.cpp \
        ProductFormViewModel.cpp \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


INCLUDEPATH += \
    ../data
    ../customer-app-qml

HEADERS += \
    ../customer-app-qml/ProductListModel.h \
    ../data/AbsDatabase.h \
    ../data/Category.h \
    ../data/Product.h \
    ../data/ProductionDatabase.h \
    ../data/ProductsDao.h \
    ProductFormViewModel.h

QT += quick sql

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        ../data/Category.cpp \
        ../data/OrderDao.cpp \
        ../data/OrderProduct.cpp \
        ../data/Product.cpp \
        ../data/ProductionDatabase.cpp \
        ../data/ProductsDao.cpp \
        OrderViewModel.cpp \
        OrderViewModelCallback.cpp \
        ProductViewModel.cpp \
        ProductViewModelCallback.cpp \
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

HEADERS += \
    ../data/AbsDatabase.h \
    ../data/Category.h \
    ../data/OrderDao.h \
    ../data/OrderProduct.h \
    ../data/Product.h \
    ../data/ProductionDatabase.h \
    ../data/ProductsDao.h \
    OrderViewModel.h \
    OrderViewModelCallback.h \
    ProductViewModel.h \
    ProductViewModelCallback.h

INCLUDEPATH += \
    ../data


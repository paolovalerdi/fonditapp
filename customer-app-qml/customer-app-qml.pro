QT += quick sql

CONFIG += c++11

SOURCES += \
        ../data/Category.cpp \
        ../data/Order.cpp \
        ../data/OrderDao.cpp \
        ../data/OrderProduct.cpp \
        ../data/Product.cpp \
        ../data/ProductionDatabase.cpp \
        ../data/ProductsDao.cpp \
        ../data/Tables.cpp \
        ../data/TablesDao.cpp \
        CategoryListModel.cpp \
        OrderMediator.cpp \
        OrderProductListModel.cpp \
        ProductListModel.cpp \
        TablesModel.cpp \
        main.cpp

HEADERS += \
    ../data/AbsDatabase.h \
    ../data/Category.h \
    ../data/Order.h \
    ../data/OrderDao.h \
    ../data/OrderProduct.h \
    ../data/Product.h \
    ../data/ProductionDatabase.h \
    ../data/ProductsDao.h \
    ../data/Tables.h \
    ../data/TablesDao.h \
    CategoryListModel.h \
    OrderMediator.h \
    OrderProductListModel.h \
    ProductListModel.h \
    TablesModel.h

RESOURCES += qml.qrc

INCLUDEPATH += \
    ../data


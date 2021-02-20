QT += quick sql websockets

CONFIG += c++11

SOURCES += \
        ../data/Category.cpp \
        ../data/DatabaseSocket.cpp \
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
        TableListModel.cpp \
        main.cpp

HEADERS += \
    ../data/AbsDatabase.h \
    ../data/Category.h \
    ../data/DatabaseObserver.h \
    ../data/DatabaseSocket.h \
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
    TableListModel.h

RESOURCES += qml.qrc

INCLUDEPATH += \
    ../data


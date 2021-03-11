QT -= gui
QT += sql websockets

CONFIG += c++11
CONFIG += console
CONFIG -= app_bundle

SOURCES += \
        Category.cpp \
        DatabaseSocket.cpp \
        Order.cpp \
        OrderDao.cpp \
        OrderProduct.cpp \
        Product.cpp \
        ProductionDatabase.cpp \
        ProductsDao.cpp \
        Question.cpp \
        Tables.cpp \
        TablesDao.cpp \
        main.cpp

HEADERS += \
    AbsDatabase.h \
    Category.h \
    DatabaseObserver.h \
    DatabaseSocket.h \
    Order.h \
    OrderDao.h \
    OrderProduct.h \
    Product.h \
    ProductionDatabase.h \
    ProductsDao.h \
    Question.h \
    Tables.h \
    TablesDao.h

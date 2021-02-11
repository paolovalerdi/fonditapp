QT -= gui
QT += sql

CONFIG += c++11
CONFIG += console
CONFIG -= app_bundle

SOURCES += \
        Category.cpp \
        Order.cpp \
        OrderDao.cpp \
        OrderProduct.cpp \
        Product.cpp \
        ProductionDatabase.cpp \
        ProductsDao.cpp \
        main.cpp

HEADERS += \
    AbsDatabase.h \
    Category.h \
    Order.h \
    OrderDao.h \
    OrderProduct.h \
    Product.h \
    ProductionDatabase.h \
    ProductsDao.h

QT += core sql
QT -= gui

TARGET = DatabaseUnitTests

CONFIG += console
CONFIG += c++11
CONFIG -= app_bundle

SOURCES += \
        ../data/Category.cpp \
        ../data/OrderDao.cpp \
        ../data/OrderProduct.cpp \
        ../data/Product.cpp \
        ../data/ProductionDatabase.cpp \
        ../data/ProductsDao.cpp \
        Sprint4Test.cpp \
        TestDatabase.cpp \
        main.cpp

HEADERS += \
    ../data/AbsDatabase.h \
    ../data/Category.h \
    ../data/OrderDao.h \
    ../data/OrderProduct.h \
    ../data/Product.h \
    ../data/ProductionDatabase.h \
    ../data/ProductsDao.h \
    TestDatabase.h

INCLUDEPATH += \
    ../lib \
    ../data

DESTDIR = $$PWD/../build

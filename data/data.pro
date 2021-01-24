QT -= gui
QT += sql

CONFIG += c++11
CONFIG += console
CONFIG -= app_bundle

SOURCES += \
        Category.cpp \
        Product.cpp \
        ProductionDatabase.cpp \
        main.cpp

HEADERS += \
    AbsDatabase.h \
    Category.h \
    Product.h \
    ProductionDatabase.h

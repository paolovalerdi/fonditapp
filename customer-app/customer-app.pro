QT += core gui sql

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET += CustomerApp

CONFIG += c++11

SOURCES += \
    ../data/Category.cpp \
    ../data/Product.cpp \
    ../data/ProductionDatabase.cpp \
    ../data/ProductsDao.cpp \
    HomeWindow.cpp \
    main.cpp \
    MainWindow.cpp

HEADERS += \
    ../data/AbsDatabase.h \
    ../data/Category.h \
    ../data/Product.h \
    ../data/ProductionDatabase.h \
    ../data/ProductsDao.h \
    HomeWindow.h \
    MainWindow.h

FORMS += \
    HomeWindow.ui \
    MainWindow.ui

INCLUDEPATH += \
    ../data

DESTDIR = $$PWD/../build

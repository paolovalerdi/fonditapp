QT += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET += CustomerApp

CONFIG += c++11

SOURCES += \
    main.cpp \
    MainWindow.cpp

HEADERS += \
    MainWindow.h

FORMS += \
    MainWindow.ui

DESTDIR = $$PWD/../build

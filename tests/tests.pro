QT += core
QT -= gui

TARGET = DatabaseUnitTests

CONFIG += console
CONFIG += c++11
CONFIG -= app_bundle

SOURCES += \
        CalculatorTest.cpp \
        main.cpp

HEADERS += \
    Calculator.h

INCLUDEPATH += \
    ../lib

DESTDIR = $$PWD/../build

QT += core

TARGET = DatabaseUnitTests

CONFIG += console
CONFIG += c++11

SOURCES += \
        CalculatorTest.cpp \
        main.cpp

HEADERS += \
    Calculator.h

INCLUDEPATH += \
    ../lib

DESTDIR = $$PWD/../build

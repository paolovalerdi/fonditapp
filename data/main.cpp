#include <QCoreApplication>
#include "ProductionDatabase.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    ProductionDatabase::getInstance();
    return a.exec();
}

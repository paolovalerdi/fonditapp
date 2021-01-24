#include <QCoreApplication>
#include <QSqlDatabase>
#include "ProductionDatabase.h"
#include "ProductsDao.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    ProductsDao dao(ProductionDatabase::getInstance());
    for(auto product : dao.getProductsByCategory(1)) {
        qDebug() << product.getName();
    }
    return a.exec();
}

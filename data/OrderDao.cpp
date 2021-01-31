#include "OrderDao.h"

OrderDao::OrderDao(AbsDatabase* database)
{
    this->database = database;
}

int OrderDao::createOrder(int idTable)
{
    auto query = database->executeQuery(
                QString("INSERT INTO orders(id_table) VALUES(%1);")
                .arg(idTable)
                );
    return query.lastInsertId().toInt();
}

void OrderDao::insertIntoOrder(QList<OrderProduct> list, int idOrder)
{
    for(auto value : list)
    {
        auto query = database->executeQuery(
                    QString("INSERT INTO order_products(id_product,quantity,id_order) VALUES(%1,%2,%,3);")
                    .arg(value.getIdProduct())
                    .arg(value.getQuantity())
                    .arg(idOrder));
    }
}

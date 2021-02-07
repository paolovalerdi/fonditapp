#include "OrderDao.h"

OrderDao::OrderDao(AbsDatabase* database)
{
    this->database = database;
    //productDao = ProductsDao(database);
}

int OrderDao::createOrder(int idTable) const
{
    auto query = database->executeQuery(
                QString("INSERT INTO orders(id_table) VALUES(%1);")
                .arg(idTable)
                );
    return query.lastInsertId().toInt();
}

void OrderDao::insertIntoOrder(QList<OrderProduct> list, int idOrder) const
{
    for(auto value : list)
    {
        auto query = database->executeQuery(
                    QString("INSERT INTO order_products(id_product,quantity,id_order) VALUES(%1,%2,%3);")
                    .arg(value.getIdProduct())
                    .arg(value.getQuantity())
                    .arg(idOrder));
    }
}

QList<OrderProduct> OrderDao::getProductsByOrderId(int idOrder) const
{
    QList<OrderProduct> list;
    auto query = database->executeQuery(
                QString("SELECT * FROM order_products WHERE id_order = %1;")
                .arg(idOrder)
                );
    while(query.next())
    {
        list.append(OrderProduct(query.value("id_product").toInt(),query.value("quantity").toInt(),query.value("id_order").toInt()));
    }
    return list;
}

double OrderDao::calculateTotal(int idOrder) const
{
    double total=0;
    auto query = database->executeQuery(
                QString("SELECT sum(products.price) FROM order_products INNER JOIN products on order_products.id_product = products.id_product WHERE order_products.id_order = %1")
                .arg(idOrder)
                );
    while(query.next())
        total = query.value(0).toDouble();

    return total;
}

QString OrderDao::getStatus(int idOrder) const
{
    QString status;
    auto query = database->executeQuery(
                QString("SELECT order_status.name FROM order_status INNER JOIN orders ON order_status.id_status = orders.id_status WHERE orders.id_order = %1")
                .arg(idOrder)
                );
    while(query.next())
        status = query.value(0).toString();

    return status;
}

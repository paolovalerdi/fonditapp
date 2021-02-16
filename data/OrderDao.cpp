#include <QDebug>
#include "OrderDao.h"
#include "Order.h"

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
    auto orignialList = getProductsByOrderId(idOrder);
    for(auto originalValue : orignialList)
    {
        for(int i=0; i< list.size();i++)
        {
            if(originalValue.getIdProduct()==list.at(i).getIdProduct())
            {
                list.removeAt(i);
            }
        }
    }
    for(auto value : list)
    {

        database->executeQuery(
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

void OrderDao::insertIntoBill(int idOrder) const
{
    QDateTime cData = QDateTime::currentDateTime();

    auto query = database->executeQuery(
                QString("INSERT INTO bill(id_order,date) VALUES(%1,NOW());")
                .arg(idOrder)
                );


}

QList<Order> OrderDao::getOrdersByStatus(int id_s)
{
    QList<Order> result;
    auto query = database->executeQuery(
                QString("SELECT * FROM orders WHERE id_status = %1")
                .arg(id_s)
                );
    while(query.next())
        result.append(Order(query.value("id_order").toInt(),query.value("id_table").toInt(),query.value("id_status").toInt(),calculateTotal(query.value("id_order").toInt())));
    return result;
}

void OrderDao::updateOrderStatus(Order order)
{
    QString queryStr = QString("UPDATE orders SET id_status = %1 WHERE id_order = %2");
    switch(order.getId_status()){
    case 3:
        queryStr = queryStr.arg(4);
        break;
    case 4:
        queryStr = queryStr.arg(5);
        break;
    case 5:
        queryStr = queryStr.arg(6);
        break;
    default:
        throw "wut?!";
        break;
    }
    queryStr=queryStr.arg(order.getId_order());
    auto query = database->executeQuery(queryStr);
}

Order OrderDao::getOrderById(int id)
{
    auto query = database->executeQuery(
                QString("SELECT * FROM orders WHERE id_order = %1")
                .arg(id)
                );
    if (query.next()) {
        return Order(query.value("id_order").toInt(),
                     query.value("id_table").toInt(),
                     query.value("id_status").toInt(),
                     calculateTotal(query.value("id_order").toInt()));
    }
    throw "No such order";
}

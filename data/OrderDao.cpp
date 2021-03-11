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

void OrderDao::insertIntoOrder(OrderProduct orderProduct, int idOrder) const
{
    database->executeQuery(
                QString("INSERT INTO order_products(id_product,quantity,id_order) VALUES(%1,%2,%3);")
                .arg(orderProduct.getIdProduct())
                .arg(orderProduct.getQuantity())
                .arg(idOrder));
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
        list.append(OrderProduct(query.value("id_product").toInt(),
                                 query.value("quantity").toInt(),
                                 query.value("id_order").toInt(),
                                 query.value("ready").toBool()));
    }
    return list;
}

double OrderDao::calculateTotal(int idOrder) const
{
    double total=0;
    auto query = database->executeQuery(
                QString("SELECT sum(products.price*order_products.quantity) FROM order_products INNER JOIN products on order_products.id_product = products.id_product WHERE order_products.id_order = %1")
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
    qDebug()<<"Id de la orden a insertar: "<<idOrder;
    auto query = database->executeQuery(QString("INSERT INTO bill(id_order,date) VALUES(%1,NOW());")
                                        .arg(idOrder)
                                        );


}

QList<Order> OrderDao::getOrdersByStatus(int id_s)
{
    QList<Order> result;
    auto query = database->executeQuery(
                QString("select o.*, t.request from orders as o INNER JOIN tables as t on o.id_table=t.id_table  WHERE id_status = %1 ORDER BY o.id_order")
                .arg(id_s)
                );
    while(query.next())
        result.append(Order(query.value("id_order").toInt(),
                            query.value("id_table").toInt(),
                            query.value("id_status").toInt(),
                            query.value("request").toInt(),
                            calculateTotal(query.value("id_order").toInt()),
                            query.value("ready").toBool()));
    return result;
}

QList<Order> OrderDao::getNotReadyOrders()
{
    QList<Order> result;
    auto query = database->executeQuery(
                QString("select o.*, t.request from orders as o INNER JOIN tables as t on o.id_table=t.id_table WHERE id_status = 4 AND ready = 0 ORDER BY o.id_order")
                );
    while(query.next())
        result.append(Order(query.value("id_order").toInt(),
                            query.value("id_table").toInt(),
                            query.value("id_status").toInt(),
                            query.value("request").toInt(),
                            calculateTotal(query.value("id_order").toInt()),
                            query.value("ready").toBool()));
    return result;
}

void OrderDao::updateOrderIsReady(int idOrder, bool isReady)
{
    QString queryStr = QString("UPDATE orders SET ready = %1 WHERE id_order = %2")
            .arg(isReady)
            .arg(idOrder);
    database->executeQuery(queryStr);
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

void OrderDao::updateOrderProductIsReady(int idOrderProduct, int idOrder, bool isReady)
{
    QString queryStr = QString("UPDATE order_products SET ready = %1 WHERE id_product = %2 AND id_order = %3")
            .arg(isReady)
            .arg(idOrderProduct)
            .arg(idOrder);
    database->executeQuery(queryStr);
}

Order OrderDao::getOrderById(int id)
{
    auto query = database->executeQuery(
                QString("select o.*, t.request from orders as o INNER JOIN tables as t on o.id_table=t.id_table WHERE id_order = %1")
                .arg(id)
                );
    if (query.next()) {
        return Order(query.value("id_order").toInt(),
                     query.value("id_table").toInt(),
                     query.value("id_status").toInt(),
                     query.value("request").toInt(),
                     calculateTotal(query.value("id_order").toInt()),
                     query.value("ready").toBool());
    }
    throw "No such order";
}

void OrderDao::updateRequest(int id) const
{
    QString e=QString("UPDATE tables as T INNER JOIN orders as O ON T.id_table=O.id_table set T.request=1 where O.id_order=%1")
            .arg(id);
    auto query = database->executeQuery(e);
}

int OrderDao::getRequest() const
{
    int band;
    auto query= database->executeQuery(QString("SELECT COUNT(request) FROM tables WHERE request=1 "));
    while (query.next()) {
        band=query.value(0).toInt();
    }
    return band;
}

void OrderDao::updateNewQuantityProduct(int idProduct, int quantity)
{
    QString e=QString("UPDATE order_products SET quantity=%1 WHERE id_product=%2")
            .arg(quantity)
            .arg(idProduct);
    auto query = database->executeQuery(e);
}

void OrderDao::updateStatus(int idOrder){
     QString queryStr = QString("UPDATE orders SET id_status = 4, ready = 0 WHERE id_order = %1").arg(idOrder);
     qDebug()<<"QUERY EJECUTADO"<<queryStr;
     auto query = database->executeQuery(queryStr);
}

bool OrderDao::orderIsReady(int idOrder){
    bool status;
    auto query = database->executeQuery(
                QString("SELECT ready FROM orders WHERE id_order = %1")
                .arg(idOrder)
                );
    while(query.next())
        status = query.value(0).toBool();

    return status;
}

QList<OrderProduct> OrderDao::getProductsNotReadyByOrderId(int idOrder) const
{
    QList<OrderProduct> list;
    auto query = database->executeQuery(
                QString("SELECT * FROM order_products WHERE id_order = %1 AND ready=0;")
                .arg(idOrder)
                );
    while(query.next())
    {
        list.append(OrderProduct(query.value("id_product").toInt(),
                                 query.value("quantity").toInt(),
                                 query.value("id_order").toInt(),
                                 query.value("ready").toBool()));
    }
    return list;
}





#include "catch.hpp"
#include "TestDatabase.h"
#include "OrderDao.h"
#include "OrderProduct.h"

TEST_CASE("Adding more products to an order doesn't duplicate already existing items") {
    OrderDao orderDao = OrderDao(new TestDatabase());

    int tableId = 2;
    auto list = QList<OrderProduct>();
    auto orderId = orderDao.createOrder(tableId);

    // Order x
    // - 1
    // - 2
    list.append(OrderProduct(1, 1, orderId));
    list.append(OrderProduct(2, 1, orderId));
    orderDao.insertIntoOrder(list, orderId);

    // Order x
    // - 1 -- duplicated
    // - 2 -- duplicated
    // - 3
    // - 4
    auto newList = QList<OrderProduct>(list);
    newList.append(OrderProduct(3, 1, orderId));
    newList.append(OrderProduct(4, 1, orderId));
    orderDao.insertIntoOrder(newList, orderId);

    REQUIRE(orderDao.getProductsByOrderId(orderId).size() == 4);
}

TEST_CASE("Update order progress")
{
    OrderDao orderDao = OrderDao(new TestDatabase());
    auto idOrder= orderDao.getOrderById(2);
    QString status = orderDao.getStatus(idOrder.getId_order());
    int progress;

    if(status=="Pendiente")
    {
        progress=33;

    }else if(status=="En progreso")
    {
        progress=66;
    }if(status=="Entregada")
    {
        progress=100;
    }
    REQUIRE(progress==100);


}

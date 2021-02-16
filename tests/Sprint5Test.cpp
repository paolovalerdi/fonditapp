#include "catch.hpp"
#include "TestDatabase.h"
#include "OrderDao.h"

TEST_CASE("Update order status") {
    OrderDao orderDao = OrderDao(new TestDatabase());
    auto testOrder = orderDao.getOrderById(1);
    orderDao.updateOrderStatus(testOrder);
    testOrder = orderDao.getOrderById(1);
    REQUIRE(testOrder.getId_status() == 4);

}

TEST_CASE("Request bill")
{
    OrderDao orderDao=OrderDao(new TestDatabase());
    auto numResquest=orderDao.getRequest();
    REQUIRE(numResquest==1);
}

TEST_CASE("Update request")
{
    OrderDao orderDao=OrderDao(new TestDatabase());
    auto testOrder2 = orderDao.getOrderById(1);
    qDebug()<<QString::number(testOrder2.getCall_waiter()); //0
    orderDao.updateRequest(testOrder2.getId_order());
    testOrder2 = orderDao.getOrderById(1);
    qDebug()<<QString::number(testOrder2.getCall_waiter());

    REQUIRE(testOrder2.getCall_waiter()==1);
}



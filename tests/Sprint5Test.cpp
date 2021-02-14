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

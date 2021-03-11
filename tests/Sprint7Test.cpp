#include "catch.hpp"
#include "TestDatabase.h"
#include "OrderDao.h"
#include "OrderProduct.h"
#include <QDebug>

TEST_CASE("Get Not ready orders list") {

    OrderDao orderDao = OrderDao(new TestDatabase());

    auto list = orderDao.getNotReadyOrders();
    auto list2 = orderDao.getOrdersByStatus(4);
    int cont=0;

    for(int i=0;i<list2.size();i++){
        if(list2[i].getReady()==0)
            cont++;
    }

    REQUIRE(list.size() == cont);
}


TEST_CASE("update ready order") {

    OrderDao orderDao = OrderDao(new TestDatabase());

    orderDao.updateOrderIsReady(1,1);
    auto testOrder = orderDao.getOrderById(1);

    qDebug()<<"La orden 1 tiene ready: " + QString::number(testOrder.getReady());

    REQUIRE(testOrder.getReady() == true);
}





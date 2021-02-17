#include "WaiterBoardMediator.h"

WaiterBoardMediator::WaiterBoardMediator(QObject *parent) : QObject(parent)
{

}

void WaiterBoardMediator::updateOrderStatus(int orderId)
{
    orderDao.updateOrderStatus(orderDao.getOrderById(orderId));
    updateBoard();
}

void WaiterBoardMediator::updateBoard()
{
    emit onBoardUpdated();
}
int WaiterBoardMediator::requestBill()
{
   return orderDao.getRequest();
}

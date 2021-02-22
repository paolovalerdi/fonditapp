#include "WaiterBoardMediator.h"

WaiterBoardMediator::WaiterBoardMediator(QObject *parent) : QObject(parent)
{

}

void WaiterBoardMediator::updateOrderStatus(int orderId)
{
    orderDao.updateOrderStatus(orderDao.getOrderById(orderId));
    updateBoard();
    QJsonObject update_order_event {
        {"target", "customer"},
        {"key", "update_order_status"},
        {"idOrder", orderId}
    };
    DatabaseSocket::getInstance()->sendEvent(update_order_event);
}

void WaiterBoardMediator::updateBoard()
{
	emit onBoardUpdated();
}

void WaiterBoardMediator::closeOrder(int orderId)
{
	orderDao.updateOrderStatus(orderDao.getOrderById(orderId));
	updateBoard();
	QJsonObject closeOrderEvent {
		{"target", "customer"},
		{"key", "close_order"},
		{"idOrder", orderId}
	};
	DatabaseSocket::getInstance()->sendEvent(closeOrderEvent);
}
int WaiterBoardMediator::requestBill()
{
   return orderDao.getRequest();
}

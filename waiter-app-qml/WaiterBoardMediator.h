#pragma once

#include <QObject>
#include <QJsonObject>

#include "ProductionDatabase.h"
#include "OrderDao.h"
#include "DatabaseSocket.h"

class WaiterBoardMediator : public QObject
{
    Q_OBJECT
public:
    explicit WaiterBoardMediator(QObject *parent = nullptr);

public slots:
    void updateOrderStatus(int orderId);
    int requestBill();
    void updateBoard();
		void closeOrder(int orderId);

signals:
    void onBoardUpdated();

private:
    OrderDao orderDao = OrderDao(ProductionDatabase::getInstance());

};

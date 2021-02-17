#pragma once

#include <QObject>

#include "ProductionDatabase.h"
#include "OrderDao.h"

class WaiterBoardMediator : public QObject
{
    Q_OBJECT
public:
    explicit WaiterBoardMediator(QObject *parent = nullptr);

public slots:
    void updateOrderStatus(int orderId);
    int requestBill();
    void updateBoard();

signals:
    void onBoardUpdated();

private:
    OrderDao orderDao = OrderDao(ProductionDatabase::getInstance());

};

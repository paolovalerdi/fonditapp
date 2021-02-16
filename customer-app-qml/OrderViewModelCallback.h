#pragma once
#include "OrderDao.h"
#include "ProductionDatabase.h"
#include <QObject>

class OrderViewModelCallback : public QObject
{
    Q_OBJECT
public:
    explicit OrderViewModelCallback(QObject *parent = nullptr);

signals:
    void onAddProduct(int idProduct,int quantity);
    void onCreatedOrder(int idOrder);
    void onViewStatus(int idOrder);
    void onLoadOrder(int idOrder);
public slots:
    void addProduct(int idProduct,int quantity);
    void createdOrder(int idTable);
    int getIdCurrentId();
    void loadOrder(int idOrder);
    double getTotal();
    QString getStatus();
    void insertIntoBill(int idOrder);
    void request();
private:
    int idOrder=-1;
    const OrderDao orderdao = OrderDao(ProductionDatabase::getInstance());
};



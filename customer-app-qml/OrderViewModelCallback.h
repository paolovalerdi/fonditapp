#pragma once
#include "OrderDao.h"
#include "ProductionDatabase.h"
#include <QObject>

class OrderViewModelCallback : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int idOrder READ getIdOrder WRITE setIdOrder)
public:
    explicit OrderViewModelCallback(QObject *parent = nullptr);

    int getIdOrder() const;
    void setIdOrder(int value);

signals:
    void onAddProduct(int idProduct,int quantity);
    void onCreatedOrder(int idOrder);
    void onViewStatus(int idOrder);
    void onLoadOrder(int idOrder);
    void onUpdateProductQuantity(int idProduct,int quantity);
public slots:
    void addProduct(int idProduct,int quantity);
    void createdOrder(int idTable);
    int getIdCurrentId();
    void loadOrder(int idOrder);
    double getTotal();
    QString getStatus();
    void insertIntoBill(int idOrder);
    void request();
    void updateProductQuantity(int idProduct, int quantity);
    
private:
    int idOrder=-1;
    const OrderDao orderdao = OrderDao(ProductionDatabase::getInstance());
};



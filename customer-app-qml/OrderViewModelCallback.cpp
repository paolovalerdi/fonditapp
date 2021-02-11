#include "OrderViewModelCallback.h"
#include <QDebug>
OrderViewModelCallback::OrderViewModelCallback(QObject *parent) : QObject(parent)
{

}

void OrderViewModelCallback::addProduct(int idProduct, int quantity)
{
    emit onAddProduct(idProduct,quantity);
}

void OrderViewModelCallback::createdOrder(int idTable)
{
    idOrder = orderdao.createOrder(idTable);
    emit onCreatedOrder(idTable);
}

int OrderViewModelCallback::getIdCurrentId()
{
    return idOrder;
}

void OrderViewModelCallback::loadOrder(int idOrder)
{
    emit onLoadOrder(idOrder);
}

double OrderViewModelCallback::getTotal()
{
    if(idOrder!=-1)
        return orderdao.calculateTotal(idOrder);
    else
        return 0;
}

QString OrderViewModelCallback::getStatus()
{
    return orderdao.getStatus(idOrder);
}

void OrderViewModelCallback::insertIntoBill(int idOrder)
{
    orderdao.insertIntoBill(idOrder);
}

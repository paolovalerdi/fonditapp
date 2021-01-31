#include "OrderViewModelCallback.h"

OrderViewModelCallback::OrderViewModelCallback(QObject *parent) : QObject(parent)
{

}

void OrderViewModelCallback::addProduct(int idProduct, int quantity)
{
    emit onAddProduct(idProduct,quantity);
}

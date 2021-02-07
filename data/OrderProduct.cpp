#include "OrderProduct.h"

OrderProduct::OrderProduct()
{

}

OrderProduct::OrderProduct(int idProduct, int quantity, int idOrder)
{
    this->idProduct=idProduct;
    this->quantity=quantity;
    this->idOrder=idOrder;
}

OrderProduct::OrderProduct(int idProduct, int quantity)
{
    this->idProduct=idProduct;
    this->quantity=quantity;
    this->idOrder = -1;
}

int OrderProduct::getIdProduct() const
{
    return idProduct;
}

int OrderProduct::getQuantity() const
{
    return quantity;
}

int OrderProduct::getIdOrder() const
{
    return idOrder;
}

void OrderProduct::setIdOrder(int value)
{
    idOrder = value;
}

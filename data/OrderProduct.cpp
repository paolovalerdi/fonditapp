#include "OrderProduct.h"

OrderProduct::OrderProduct(int idProduct, int quantity, int idOrder, bool ready)
{
	this->idProduct = idProduct;
	this->quantity = quantity;
	this->idOrder = idOrder;
	this->ready = ready;
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

bool OrderProduct::operator ==(const OrderProduct& other) const
{
	return idProduct == other.idProduct;
}

bool OrderProduct::operator !=(const OrderProduct& other) const
{
	return idProduct != other.idProduct;
}

bool OrderProduct::getReady() const
{
	return ready;
}

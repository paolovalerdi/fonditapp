#include "OrderMediator.h"
#include <QDebug>
OrderMediator::OrderMediator(QObject *parent) : QObject(parent)
{

}

double OrderMediator::getTotal()
{
	return total;
}

Product OrderMediator::asProduct(OrderProduct orderProduct)
{
	return productsDao.getProductById(orderProduct.getIdProduct());
}

QList<OrderProduct> OrderMediator::getOrderProducts() const
{
	return orderProducts;
}

void OrderMediator::linkTable(int idTable)
{
	if (idTable == -1) {
		this->idTable = idTable;
		// TODO:
	}
}

void OrderMediator::createOrder()
{
	if (idOrder == -1 && idTable != -1) {
		idOrder = orderDao.createOrder(this->idTable);
		// TODO: Emit to server
		emit orderCreated();
	}
}

void OrderMediator::addProduct(int idProduct, int quantity)
{
	// TODO: The source of truth should be the db not an in-memory list
	if (idOrder != -1) {
		orderProducts.append(OrderProduct(idProduct, quantity, idOrder));
		emit productsUpdated();
	}
}

void OrderMediator::updateProductQuantity(int index, int quantity)
{
	if (idOrder != -1) {
		auto original = orderProducts.at(index);
		orderProducts.replace(index, OrderProduct(original.getIdProduct(),
																							quantity,
																							original.getIdOrder()));
		emit productUpdated(index);
	}
}

void OrderMediator::updateTotal()
{
	total = 0;
	for (auto orderProduct : qAsConst(orderProducts)) {
		auto product = asProduct(orderProduct);
		total += (product.getPrice() * orderProduct.getQuantity());
	}
	emit totalUpdated();
}

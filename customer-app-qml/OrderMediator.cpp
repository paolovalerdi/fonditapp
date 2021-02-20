#include "OrderMediator.h"
#include <QDebug>

OrderMediator::OrderMediator(QObject *parent) : QObject(parent)
{
	DatabaseSocket::getInstance()->addObserver(this);
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

void OrderMediator::onEventRecieved(QJsonObject event)
{
}

void OrderMediator::linkTable(int idTable)
{
	if (this->idTable == -1) {
		this->idTable = idTable;
		tableDao.updateOcupied(this->idTable, true);
	}
}

void OrderMediator::createOrder()
{
	if (idOrder == -1 && idTable != -1) {
		idOrder = orderDao.createOrder(idTable);
		DatabaseSocket::getInstance()->sendEvent(QJsonObject {
																							 {"target", "waiter"},
																							 {"event", "new_order"},
																							 {"orderId", idOrder}
																						 });
		emit orderCreated();
	}
}

void OrderMediator::addProduct(int idProduct, int quantity)
{
	if (orderProducts.contains(OrderProduct(idProduct))) {
		auto original = orderProducts.at(orderProducts.indexOf(idProduct));
		updateProductQuantity(idProduct, original.getQuantity() + quantity);
	} else {
		orderProducts.append(OrderProduct(idProduct, quantity));
		emit productsUpdated();
	}
}

void OrderMediator::updateProductQuantity(int idProduct, int quantity)
{
	auto index = orderProducts.indexOf(OrderProduct(idProduct));
	auto original = orderProducts.at(index);
	orderProducts.replace(index, OrderProduct(original.getIdProduct(),
																						quantity,
																						original.getIdOrder()));
	emit productUpdated(index);
}

void OrderMediator::removeProduct()
{

}

void OrderMediator::replay()
{

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

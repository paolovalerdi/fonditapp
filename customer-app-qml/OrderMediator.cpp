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

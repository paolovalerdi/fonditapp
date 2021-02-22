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
	if (event["target"] == "customer") {
		if (event["key"] == "close_order") {
			if (event["idOrder"] == idOrder) {
				tableDao.updateOcupied(idTable, false);
				idOrder = -1;
				status = -1;
				orderProducts.clear();
				total = 0.0;
				qDebug() << "Orden cerrada";
				emit productsUpdated();
				// TODO: Show survey
			}
		}
        if(event["key"]== "update_order_status")
        {
            if (event["idOrder"] == idOrder) {

                status=orderDao.getOrderById(idOrder).getId_status();
                switch (status) {

                case 3: progress=33;
                        break;

                case 4: progress=66;
                        break;
                case 5: progress=100;
                        break;
                }
                emit statusUpdated();
            }
        }
	}
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
        orderDao.insertIntoOrder(orderProducts,idOrder);
		QJsonObject createOrderEvent {
			{"target", "waiter"},
			{"key", "create_order"},
			{"idOrder", idOrder}
		};
		DatabaseSocket::getInstance()->sendEvent(createOrderEvent);
		emit orderCreated();
        status=3;
        updateTotal();
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

    updateTotal();
}

void OrderMediator::updateProductQuantity(int idProduct, int quantity)
{
	auto index = orderProducts.indexOf(OrderProduct(idProduct));
	auto original = orderProducts.at(index);
	orderProducts.replace(index, OrderProduct(original.getIdProduct(),
                                                                                        quantity,
																						original.getIdOrder()));
	emit productUpdated(index);
    updateTotal();
}

void OrderMediator::removeProduct()
{

}

void OrderMediator::replay()
{
    emit statusUpdated();
    emit totalUpdated();
}

int OrderMediator::getStatus() const
{
    return status;
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

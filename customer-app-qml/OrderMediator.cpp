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
        qDebug() << "R"<<event["key"];
        if (event["key"] == "close_order") {
            if (event["idOrder"] == idOrder) {
                tableDao.updateOcupied(idTable, false);
                orderDao.insertIntoBill(idOrder);
                idOrder = -1;
                status = -1;
                orderProducts.clear();
                total = 0.0;
                qDebug() << "Orden cerrada";
                emit productsUpdated();
                emit orderClosed();
                // TODO: Show survey
            }
        }
        if(event["key"] == "update_progress") {
            emit progressUpdated(event["progress"].toDouble());
            emit readyUpdated();
            emit productsUpdated();
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
        lastIndex = orderProducts.size();
        updateTotal();
    }
    else{
         QList<OrderProduct> nuevosProductos(orderProducts.mid(lastIndex,orderProducts.size()));
         orderDao.insertIntoOrder(nuevosProductos,idOrder);
         if(orderDao.orderIsReady(idOrder)==1){
            updateStatus();
            QJsonObject updateOrderListEvent {
                {"target", "waiter"},
                {"key", "update_orderlist"}
            };
            DatabaseSocket::getInstance()->sendEvent(updateOrderListEvent);
            QJsonObject updateQueueEvent {
                {"target", "chef"},
                {"key", "update_queue"}
            };
            DatabaseSocket::getInstance()->sendEvent(updateQueueEvent);
         }
        lastIndex = orderProducts.size();
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
    orderDao.updateNewQuantityProduct(idProduct,quantity);
}

void OrderMediator::removeProduct()
{

}

void OrderMediator::replay()
{
    emit statusUpdated();
    emit totalUpdated();
}

void OrderMediator::updateStatus()
{
    orderDao.updateStatus(idOrder);
}


QList<OrderProduct> OrderMediator::updateListReady()
{
    orderProducts = orderDao.getProductsByOrderId(idOrder);
    return orderProducts;
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

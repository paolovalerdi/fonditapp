#pragma once

#include <QObject>
#include <QList>
#include <QJsonObject>

#include "OrderProduct.h"
#include "Product.h"
#include "OrderDao.h"
#include "ProductsDao.h"
#include "TablesDao.h"
#include "ProductionDatabase.h"
#include "DatabaseSocket.h"
#include "DatabaseObserver.h"

class OrderMediator : public QObject, public DatabaseObserver
{
		Q_OBJECT
		Q_PROPERTY(double total READ getTotal)

	public:
		explicit OrderMediator(QObject *parent = nullptr);
		double getTotal();
		Product asProduct(OrderProduct orderProduct);
		QList<OrderProduct> getOrderProducts() const;
		void onEventRecieved(QJsonObject event) override;

	signals:
		void orderCreated();
		void productsUpdated();
		void productUpdated(int index);
		void totalUpdated();
		void statusUpdated();

	public slots:
		void linkTable(int idTable);
		void createOrder();
		void addProduct(int idProduct,int quantity);
		void updateProductQuantity(int idProduct, int quantity);
		void removeProduct(); // TODO
		void replay();

	private:
		int idOrder = -1;
		int idTable = -1;
		int status = -1;
		double total = 0.0;
		QList<OrderProduct> orderProducts;
		OrderDao orderDao = OrderDao(ProductionDatabase::getInstance());
		ProductsDao productsDao = ProductsDao(ProductionDatabase::getInstance());
		TablesDao tableDao = TablesDao(ProductionDatabase::getInstance());

		void updateTotal();
};



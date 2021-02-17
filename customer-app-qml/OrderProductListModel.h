#pragma once

#include <QAbstractListModel>

#include "ProductionDatabase.h"
#include "ProductsDao.h"
#include "OrderDao.h"
#include "OrderProduct.h"
#include "OrderViewModelCallback.h"

class OrderProductListModel : public QAbstractListModel
{
		Q_OBJECT
		Q_PROPERTY(OrderViewModelCallback *callback READ getCallback WRITE setCallback)

	public:
		enum {
			ID_ROLE,
			NAME_ROLE,
			DESCRIPTION_ROLE,
			PICTURE_ROLE,
			PRICE_ROLE,
			QUANTITY_ROLE,
		};

		explicit OrderProductListModel(QObject *parent = nullptr);
		int rowCount(const QModelIndex &parent = QModelIndex()) const override;
		QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
		QHash<int, QByteArray> roleNames() const override;

		OrderViewModelCallback *getCallback() const;
		void setCallback(OrderViewModelCallback *value);

	private:
		int idOrder =-1;
		QList<OrderProduct> orderProducts;
		const OrderDao orderDao = OrderDao(ProductionDatabase::getInstance());
		const ProductsDao productDao = ProductsDao(ProductionDatabase::getInstance());
		OrderViewModelCallback *callback;
};


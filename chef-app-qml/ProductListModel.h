#pragma once

#include <QAbstractListModel>

#include "ProductionDatabase.h"
#include "ProductsDao.h"
#include "OrderDao.h"
#include "DatabaseSocket.h"

class ProductListModel : public QAbstractListModel
{
		Q_OBJECT

	public slots:
		void loadProductsByOrderId(int orderId);
        void updateReady(int index, bool isReady);

	signals:
		void enabled(bool value);

	public:
		enum {
			ID_ROLE,
			NAME_ROLE,
			PICTURE_ROLE,
            QUANTITY_ROLE,
            READY_ROLE
		};

		explicit ProductListModel(QObject *parent = nullptr);
		int rowCount(const QModelIndex &parent = QModelIndex()) const override;
		QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
		QHash<int, QByteArray> roleNames() const override;

	private:
		ProductsDao productDao = ProductsDao(ProductionDatabase::getInstance());
		OrderDao orderDao = OrderDao(ProductionDatabase::getInstance());
		QList<OrderProduct> productList;

		void calculateProgress();
};

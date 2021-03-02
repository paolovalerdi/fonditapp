#pragma once

#include <QAbstractListModel>
#include <QJsonObject>

#include "ProductionDatabase.h"
#include "OrderDao.h"
#include "ProductsDao.h"
#include "OrderProduct.h"
#include "DatabaseObserver.h"
#include "DatabaseSocket.h"

class OrderListModel : public QAbstractListModel, public DatabaseObserver
{
		Q_OBJECT

	public slots:
		void markAsReady(int idOrder);
	signals:
		void updateProductGrid(int idOrder);
		void showEmptyMessage(bool show);
	public:
		enum {
			ID_ROLE,
			ID_TABLE_ROLE,
			ID_STATUS_ROLE,
			TOTAL_ROLE,
			CALL_ROLE,
			POSITION_ROLE
		};

		explicit OrderListModel(QObject *parent = nullptr);
		int rowCount(const QModelIndex &parent = QModelIndex()) const override;
		QHash<int, QByteArray> roleNames() const override;
		QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
		void onEventRecieved(QJsonObject event) override;

	private:
		OrderDao orderDao = OrderDao(ProductionDatabase::getInstance());
		QList<Order> list;

		void update();
};


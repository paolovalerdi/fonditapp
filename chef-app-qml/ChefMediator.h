#pragma once

#include <QObject>

#include "ProductionDatabase.h"
#include "OrderDao.h"

class ChefMediator : public QObject
{
		Q_OBJECT

	public slots:
		void markAsReady(int idOrder);
	public:
		explicit ChefMediator(QObject *parent = nullptr);

	signals:
		void onUpdate();

	private:
		OrderDao orderDao = OrderDao(ProductionDatabase::getInstance());
};


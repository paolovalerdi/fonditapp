#pragma once

#include <QAbstractListModel>

#include "ProductionDatabase.h"
#include "ProductsDao.h"
#include "ProductViewModelCallback.h"

class ProductListModel : public QAbstractListModel
{
		Q_OBJECT
		Q_PROPERTY(ProductViewModelCallback *callback READ getCallback WRITE setCallback)

	public:
		enum {
			ID_ROLE,
			NAME_ROLE,
			DESCRIPTION_ROLE,
			PICTURE_ROLE,
			PRICE_ROLE
		};

		explicit ProductListModel(QObject *parent = nullptr);
		int rowCount(const QModelIndex &parent = QModelIndex()) const override;
		QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
		QHash<int, QByteArray> roleNames() const override;
		ProductViewModelCallback *getCallback() const;
		void setCallback(ProductViewModelCallback *value);

	private:
		ProductViewModelCallback *callback;
		ProductsDao productDao = ProductsDao(ProductionDatabase::getInstance());
		QList<Product> productList = productDao.getAllProducts();
};

#pragma once

#include <QAbstractListModel>

#include "ProductionDatabase.h"
#include "ProductsDao.h"

class ProductListModel : public QAbstractListModel
{
		Q_OBJECT

	public slots:
		void loadCategory(int categoryId);

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

	private:
		ProductsDao productDao = ProductsDao(ProductionDatabase::getInstance());
		QList<Product> productList = productDao.getAllProducts();
};

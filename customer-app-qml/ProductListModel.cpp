#include "ProductListModel.h"

ProductListModel::ProductListModel(QObject *parent) : QAbstractListModel(parent)
{
	loadCategory(-1);
}

int ProductListModel::rowCount(const QModelIndex &parent) const
{
	return parent.isValid() ? 0 : productList.size();
}

QVariant ProductListModel::data(const QModelIndex &index, int role) const
{
	if (!index.isValid())
		return QVariant();

	auto item = productList.at(index.row());
	switch (role) {
		case ID_ROLE:
			return QVariant(item.getId());
		case NAME_ROLE:
			return QVariant(item.getName());
		case DESCRIPTION_ROLE:
			return QVariant(item.getDescription());
		case PICTURE_ROLE:
			return QVariant("data:image/png;base64," + item.getPicture().toBase64());
		case PRICE_ROLE:
			return QVariant(item.getPrice());
		default:
			throw "No such role";
	}
}

QHash<int, QByteArray> ProductListModel::roleNames() const
{
	QHash<int, QByteArray> names;
	names[ID_ROLE] = "productId";
	names[NAME_ROLE] = "name";
	names[DESCRIPTION_ROLE] = "description";
	names[PICTURE_ROLE] = "picture";
	names[PRICE_ROLE]= "price";
	return names;
}

void ProductListModel::loadCategory(int categoryId)
{
	beginResetModel();
	if (!productList.isEmpty()) {
		beginRemoveRows(QModelIndex(), 0, productList.size() - 1);
		endRemoveRows();
	}
	productList = categoryId == -1 ? productDao.getAllProducts() : productDao.getProductsByCategory(categoryId);
	beginInsertRows(QModelIndex(), 0, productList.size() - 1);
	endInsertRows();
}

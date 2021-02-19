#include "OrderProductListModel.h"

OrderProductListModel::OrderProductListModel(QObject *parent)
	: QAbstractListModel(parent), orderMediator(nullptr)
{
}

int OrderProductListModel::rowCount(const QModelIndex &parent) const
{
	return (parent.isValid() || !orderMediator) ? 0 : orderMediator->getOrderProducts().size();
}

QVariant OrderProductListModel::data(const QModelIndex &index, int role) const
{
	if (!index.isValid() || !orderMediator)
		return QVariant();

	auto orderProduct = orderMediator->getOrderProducts().at(index.row());
	auto product = orderMediator->asProduct(orderProduct);
	switch (role) {
		case ID_ROLE:
			return QVariant(product.getId());
		case NAME_ROLE:
			return QVariant(product.getName());
		case DESCRIPTION_ROLE:
			return QVariant(product.getDescription());
		case PICTURE_ROLE:
			return QVariant("data:image/png;base64," + product.getPicture().toBase64());
		case PRICE_ROLE:
			return QVariant(product.getPrice());
		case QUANTITY_ROLE:
			return QVariant(orderProduct.getQuantity());
		default:
			throw QString("OrderProductListModel: No such role");
	}
}

QHash<int, QByteArray> OrderProductListModel::roleNames() const
{
	QHash<int, QByteArray> names;
	names[ID_ROLE] = "idProduct";
	names[NAME_ROLE] = "name";
	names[DESCRIPTION_ROLE] = "description";
	names[PICTURE_ROLE] = "picture";
	names[PRICE_ROLE]= "price";
	names[QUANTITY_ROLE]= "quantity";
	return names;
}

OrderMediator* OrderProductListModel::getOrderMediator() const
{
	return orderMediator;
}

void OrderProductListModel::setOrderMediator(OrderMediator* value)
{
	orderMediator = value;
	beginResetModel();

	connect(orderMediator, &OrderMediator::productsUpdated, this, [=] {
		auto orderProducts = orderMediator->getOrderProducts();
		beginRemoveRows(QModelIndex(), 0, orderProducts.size() - 1);
		endRemoveRows();
		beginInsertRows(QModelIndex(),0, orderProducts.size()-1);
		endInsertRows();
	});

	connect(orderMediator, &OrderMediator::productUpdated, this, [=](int index) {
		emit dataChanged(this->index(index), this->index(index));
	});
}

#include "OrderProductListModel.h"

OrderProductListModel::OrderProductListModel(QObject *parent)
	: QAbstractListModel(parent), mediator(nullptr)
{
}

int OrderProductListModel::rowCount(const QModelIndex &parent) const
{
	return (parent.isValid() || !mediator) ? 0 : mediator->getOrderProducts().size();
}

QVariant OrderProductListModel::data(const QModelIndex &index, int role) const
{
	if (!index.isValid() || !mediator)
		return QVariant();

	auto orderProduct = mediator->getOrderProducts().at(index.row());
	auto product = mediator->asProduct(orderProduct);
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
			return QVariant(product.getPrice() * orderProduct.getQuantity());
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

OrderMediator* OrderProductListModel::getMediator() const
{
	return mediator;
}

void OrderProductListModel::setMediator(OrderMediator* value)
{
	mediator = value;
	beginResetModel();

	connect(mediator, &OrderMediator::productsUpdated, this, [=] {
		auto orderProducts = mediator->getOrderProducts();
		beginRemoveRows(QModelIndex(), 0, orderProducts.size() - 1);
		endRemoveRows();
		beginInsertRows(QModelIndex(),0, orderProducts.size()-1);
		endInsertRows();
	});

	connect(mediator, &OrderMediator::productUpdated, this, [=](int index) {
		beginRemoveRows(QModelIndex(), index, index);
		endRemoveRows();
		beginInsertRows(QModelIndex(), index, index);
		endInsertRows();
	});
}

#include "OrderProductListModel.h"

OrderProductListModel::OrderProductListModel(QObject *parent)
	: QAbstractListModel(parent),callback(nullptr)
{
}

int OrderProductListModel::rowCount(const QModelIndex &parent) const
{
	return parent.isValid() ? 0 : orderProducts.size();
}

QVariant OrderProductListModel::data(const QModelIndex &index, int role) const
{
	if (!index.isValid()) return QVariant();

	auto item = productDao.getProductById(orderProducts.at(index.row()).getIdProduct());
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
		case QUANTITY_ROLE:
			return QVariant(orderProducts.at(index.row()).getQuantity());
		default:
			throw QString("OrderProductListModel: No such role");
	}
	return QVariant();
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

OrderViewModelCallback *OrderProductListModel::getCallback() const
{
	return callback;
}

void OrderProductListModel::setCallback(OrderViewModelCallback *value)
{
	beginResetModel();
	callback = value;
	connect(callback, &OrderViewModelCallback::onAddProduct, this, [=](int idProduct,int quantity) {
		beginRemoveRows(QModelIndex(), 0, orderProducts.size() - 1);
		endRemoveRows();
		orderProducts.append(OrderProduct(idProduct,quantity));
		beginInsertRows(QModelIndex(),0, orderProducts.size()-1);
		endInsertRows();
	});
	connect(callback, &OrderViewModelCallback::onCreatedOrder, this, [=](int idTable) {
		beginRemoveRows(QModelIndex(), 0, orderProducts.size() - 1);
		endRemoveRows();
		orderDao.insertIntoOrder(orderProducts,callback->getIdCurrentId());
		orderProducts.clear();
	});
	connect(callback, &OrderViewModelCallback::onLoadOrder, this, [=](int idOrder) {
		qDebug()<<"cargando...";
		beginRemoveRows(QModelIndex(), 0, orderProducts.size() - 1);
		endRemoveRows();
		orderProducts.clear();
		orderProducts = orderDao.getProductsByOrderId(idOrder);
		beginInsertRows(QModelIndex(),0, orderProducts.size()-1);
		endInsertRows();
	});
	connect(callback, &OrderViewModelCallback::onUpdateProductQuantity, this, [=](int idProduct,int quantity) {

		int i=0;
		while (true){
			if(orderProducts.at(i).getIdProduct() == idProduct)
			{
				orderProducts.at(i).setQuantity(quantity);
				break;
			}
			i++;
		}

	});

}

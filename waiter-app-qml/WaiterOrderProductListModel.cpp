#include "WaiterOrderProductListModel.h"

void WaiterOrderProductListModel::loadOrderProducts(int idOrder)
{
    qDebug()<<"id de la orden: "<<idOrder;
        beginRemoveRows(QModelIndex(), 0, OpList.size()-1);
        endRemoveRows();
        OpList = orderDao.getProductsByOrderId(idOrder);
        qDebug()<<"List size: "<<OpList.size();
        beginInsertRows(QModelIndex(),0, OpList.size()-1);
        endInsertRows();
}

WaiterOrderProductListModel::WaiterOrderProductListModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int WaiterOrderProductListModel::rowCount(const QModelIndex &parent) const
{
    return (parent.isValid()) ? 0 : OpList.size();
}

QVariant WaiterOrderProductListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    auto orderProduct = OpList.at(index.row());
    auto product = productDao.getProductById(orderProduct.getIdProduct());
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

QHash<int, QByteArray> WaiterOrderProductListModel::roleNames() const
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



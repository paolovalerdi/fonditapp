#include "OrderViewModel.h"

OrderViewModel::OrderViewModel(QObject *parent)
    : QAbstractListModel(parent),callback(nullptr)
{
}

int OrderViewModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    // FIXME: Implement me!
    return list.size();
}

QVariant OrderViewModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    auto item = productDao.getProductById(list.at(index.row()).getIdProduct());
    switch (role) {
    case NameRole:
        return QVariant(item.getName());
    case DescriptionRole:
        return QVariant(item.getDescription());
    case PictureRole:
        // QML no entiende imagenes representadas como arreglos de bits
        // es necesario convertilar a base64 y agregar el tipo.
        return QVariant("data:image/png;base64," + item.getPicture().toBase64());
    case PriceRole:
        return QVariant(item.getPrice());
    case AmountRole:
        return QVariant(list.at(index.row()).getQuantity());
    }
    return QVariant();
}

QHash<int, QByteArray> OrderViewModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[NameRole] = "name";
    names[DescriptionRole] = "description";
    names[PictureRole] = "picture";
    names[PriceRole]= "price";
    names[AmountRole]= "quantity";
    return names;
}

OrderViewModelCallback *OrderViewModel::getCallback() const
{
    return callback;
}

void OrderViewModel::setCallback(OrderViewModelCallback *value)
{
    beginResetModel();
    callback = value;
    connect(callback, &OrderViewModelCallback::onAddProduct, this, [=](int idProduct,int quantity) {
        beginRemoveRows(QModelIndex(), 0, list.size() - 1);
        endRemoveRows();
        list.append(OrderProduct(idProduct,quantity));
        beginInsertRows(QModelIndex(),0, list.size()-1);
        endInsertRows();
    });
    connect(callback, &OrderViewModelCallback::onCreatedOrder, this, [=](int idTable) {
        beginRemoveRows(QModelIndex(), 0, list.size() - 1);
        endRemoveRows();
        orderdao.insertIntoOrder(list,callback->getIdCurrentId());
        list.clear();
    });
    connect(callback, &OrderViewModelCallback::onLoadOrder, this, [=](int idOrder) {
        qDebug()<<"cargando...";
        beginRemoveRows(QModelIndex(), 0, list.size() - 1);
        endRemoveRows();
        list.clear();
        list = orderdao.getProductsByOrderId(idOrder);
        beginInsertRows(QModelIndex(),0, list.size()-1);
        endInsertRows();
    });
}

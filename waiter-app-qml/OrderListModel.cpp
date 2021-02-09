#include "OrderListModel.h"

OrderListModel::OrderListModel(QObject *parent)
    : QAbstractListModel(parent),callback(nullptr)
{
    id_status = -1;

}

int OrderListModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return list.size();
}

QVariant OrderListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if(list.size()>0){
        auto order = list.at(index.row());
        switch (role) {
        case idOrder:
            return QVariant(order.getId_order());
        case idTable:
            return QVariant(order.getId_table());
        case idStatus:
            return QVariant(order.getId_status());
        case total:
            return QVariant(order.getTotal());
        }
    }
    return QVariant();
}

QHash<int, QByteArray> OrderListModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[idOrder] = "idOrder";
    names[idTable] = "idTable";
    names[idStatus] = "idStatus";
    names[total] = "total";
    return names;
}

OrderListModelCallback *OrderListModel::getCallback() const
{
    return callback;
}

void OrderListModel::setCallback(OrderListModelCallback *value)
{
    callback = value;
    connect(callback, &OrderListModelCallback::onUpdateRequested, this, [=]() {
        beginRemoveRows(QModelIndex(), 0, list.size() - 1);
        endRemoveRows();
        list = orderdao.getOrdersByStatus(id_status);
        beginInsertRows(QModelIndex(),0, list.size()-1);
        endInsertRows();
    });

}

int OrderListModel::getId_status() const
{
    return id_status;
}

void OrderListModel::setId_status(int value)
{
    id_status = value;
    list = orderdao.getOrdersByStatus(id_status);
}

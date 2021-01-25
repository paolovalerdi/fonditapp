#include "ProductModel.h"
#include "ProductList.h"

ProductModel::ProductModel(QObject *parent)
    : QAbstractListModel(parent), callback(nullptr)
{
}

int ProductModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return something.size();
}

QVariant ProductModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    auto item = something.at(index.row());
    switch (role) {
    case NameRole:
        return QVariant(item.getName());
    case PictureRole:
        return QVariant("data:image/png;base64," + item.getPicture().toBase64());
    case PriceRole:
        return QVariant(item.getPrice());
    }
    return QVariant();
}

QHash<int, QByteArray> ProductModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[NameRole] = "name";
    names[PriceRole]= "price";
    names[PictureRole] = "picture";
    return names;
}

ProductList *ProductModel::getCallback() const
{
    return callback;
}

void ProductModel::setCallback(ProductList *value)
{
    beginResetModel();
    callback = value;
    connect(callback, &ProductList::onCategoryChanged, this, [=](int id) {
        beginRemoveRows(QModelIndex(), 0, something.size() - 1);
        endRemoveRows();
        something = productDao.getProductsByCategory(id);
        beginInsertRows(QModelIndex(), 0, something.size() - 1);
        endInsertRows();
    });
}

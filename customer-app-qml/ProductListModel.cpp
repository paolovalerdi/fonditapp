#include "ProductListModel.h"

ProductListModel::ProductListModel(QObject *parent)
    : QAbstractListModel(parent), callback(nullptr)
{
}

int ProductListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return productList.size();
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
        // QML no entiende imagenes representadas como arreglos de bits
        // es necesario convertilar a base64 y agregar el tipo.
        return QVariant("data:image/png;base64," + item.getPicture().toBase64());
    case PRICE_ROLE:
        return QVariant(item.getPrice());
    }
    return QVariant();
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

ProductViewModelCallback *ProductListModel::getCallback() const
{
    return callback;
}

void ProductListModel::setCallback(ProductViewModelCallback *value)
{
    beginResetModel();
    callback = value;
    connect(callback, &ProductViewModelCallback::onCategoryUpdated, this, [=](int id) {
        // Primero quitamos todos los elementos desde 0 hasta el final de la lista
        beginRemoveRows(QModelIndex(), 0, productList.size() - 1);
        endRemoveRows();

        // Actualizamos la lista
        productList = id==-1 ? productDao.getAllProducts():productDao.getProductsByCategory(id);

        // Insertamos los nuevos elementos desde 0 hasta el final de la lista
        beginInsertRows(QModelIndex(), 0, productList.size() - 1);
        endInsertRows();
    });

    connect(callback, &ProductViewModelCallback::onStatusSelected, this, [=]() {
        // Primero quitamos todos los elementos desde 0 hasta el final de la lista
        qDebug()<<"here";
        beginRemoveRows(QModelIndex(), 0, productList.size() - 1);
        endRemoveRows();
    });




}

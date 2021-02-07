#include "ProductViewModel.h"

ProductViewModel::ProductViewModel(QObject *parent)
    : QAbstractListModel(parent), callback(nullptr)
{
}

int ProductViewModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return productList.size();
}

QVariant ProductViewModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    auto item = productList.at(index.row());
    switch (role) {
    case IdRole:
        return QVariant(item.getId());
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
    }
    return QVariant();
}

QHash<int, QByteArray> ProductViewModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[IdRole] = "productId";
    names[NameRole] = "name";
    names[DescriptionRole] = "description";
    names[PictureRole] = "picture";
    names[PriceRole]= "price";
    return names;
}

ProductViewModelCallback *ProductViewModel::getCallback() const
{
    return callback;
}

void ProductViewModel::setCallback(ProductViewModelCallback *value)
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

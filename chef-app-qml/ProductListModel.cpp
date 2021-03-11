#include "ProductListModel.h"

void ProductListModel::loadProductsByOrderId(int orderId)
{
    beginResetModel();
    if (!productList.isEmpty()) {
        beginRemoveRows(QModelIndex(), 0, productList.size() - 1);
        endRemoveRows();
    }
    qDebug() << "Producs before " << productList.size();
    productList = orderDao.getProductsNotReadyByOrderId(orderId);
    qDebug() << "Producs after " << productList.size();
    beginInsertRows(QModelIndex(), 0, productList.size() - 1);
    endInsertRows();
}

void ProductListModel::updateReady(int index, bool isReady)
{
    qDebug() << "Updating product at " << index << " with isReady: " << isReady;
    auto original = productList.at(index);
    productList.replace(index, OrderProduct(original.getIdProduct(),
                                            original.getQuantity(),
                                            original.getIdOrder(),
                                            isReady));
    orderDao.updateOrderProductIsReady(original.getIdProduct(), original.getIdOrder(), isReady);
    calculateProgress();
    for (auto product : qAsConst(productList)) {
        if(!product.getReady()) {
            emit enabled(false);
            return;
        }
    }
    emit enabled(true);
}

ProductListModel::ProductListModel(QObject *parent) : QAbstractListModel(parent)
{
}

int ProductListModel::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : productList.size();
}

QVariant ProductListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    auto orderProduct = productList.at(index.row());
    auto item = productDao.getProductById(orderProduct.getIdProduct());
    switch (role) {
    case ID_ROLE:
        return QVariant(item.getId());
    case NAME_ROLE:
        return QVariant(item.getName());
    case PICTURE_ROLE:
        return QVariant("data:image/png;base64," + item.getPicture().toBase64());
    case QUANTITY_ROLE:
        return QVariant(orderProduct.getQuantity());
    case READY_ROLE:
        return QVariant(orderProduct.getReady());
    default:
        throw "No such role";
    }
}

QHash<int, QByteArray> ProductListModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[ID_ROLE] = "productId";
    names[NAME_ROLE] = "name";
    names[PICTURE_ROLE] = "picture";
    names[QUANTITY_ROLE] = "quantity";
    names[READY_ROLE] = "ready";
    return names;
}

void ProductListModel::calculateProgress()
{
    float total = productList.size();
    float readyCount = 0;
    for (auto product : qAsConst(productList)) {
        if(product.getReady()) {
            readyCount++;
        }
    }
    float progress = readyCount / total;
    QJsonObject updateProgressEvent {
        {"target", "customer"},
        {"key", "update_progress"},
        {"progress", progress}
    };

    DatabaseSocket::getInstance()->sendEvent(updateProgressEvent);
}

#pragma once

#include <QAbstractListModel>
#include "ProductionDatabase.h"
#include "ProductsDao.h"

class ProductList;

class ProductModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(ProductList *callback READ getCallback WRITE setCallback)

public:
    enum {
        NameRole,
        PriceRole,
        PictureRole,
    };
    explicit ProductModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    ProductList *getCallback() const;
    void setCallback(ProductList *value);

private:
    ProductsDao productDao = ProductsDao(ProductionDatabase::getInstance());
    QList<Product> something = productDao.getProductsByCategory(4);
    ProductList *callback;
};

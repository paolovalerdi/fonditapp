#pragma once
#include "OrderProduct.h"
#include <QAbstractListModel>
#include "OrderDao.h"
#include "ProductionDatabase.h"
#include "ProductsDao.h"
#include "OrderViewModelCallback.h"

class OrderViewModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(OrderViewModelCallback *callback READ getCallback WRITE setCallback)

public:
    explicit OrderViewModel(QObject *parent = nullptr);
    enum {
        NameRole,
        DescriptionRole,
        PictureRole,
        PriceRole,
        AmountRole,
    };
    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;


    OrderViewModelCallback *getCallback() const;
    void setCallback(OrderViewModelCallback *value);

private:
    QList<OrderProduct> list;
    const OrderDao orderdao = OrderDao(ProductionDatabase::getInstance());
    const ProductsDao productDao = ProductsDao(ProductionDatabase::getInstance());
    OrderViewModelCallback *callback;
};


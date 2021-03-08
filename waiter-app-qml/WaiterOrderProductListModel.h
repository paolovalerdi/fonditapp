#pragma once

#include <QAbstractListModel>

#include "Product.h"
#include "OrderProduct.h"
#include "WaiterBoardMediator.h"
#include "OrderDao.h"
#include "ProductsDao.h"
#include "ProductionDatabase.h"

class WaiterOrderProductListModel : public QAbstractListModel
{
        Q_OBJECT

  public slots:
    void loadOrderProducts(int idOrder);
    public:
        enum {
            ID_ROLE,
            NAME_ROLE,
            DESCRIPTION_ROLE,
            PICTURE_ROLE,
            PRICE_ROLE,
            QUANTITY_ROLE,
            READY_ROLE,
        };

        explicit  WaiterOrderProductListModel(QObject *parent = nullptr);
        int rowCount(const QModelIndex &parent = QModelIndex()) const override;
        QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
        QHash<int, QByteArray> roleNames() const override;

    private:
        QList<OrderProduct> OpList;
        ProductsDao productDao = ProductsDao(ProductionDatabase::getInstance());
        OrderDao orderDao = OrderDao(ProductionDatabase::getInstance());
};


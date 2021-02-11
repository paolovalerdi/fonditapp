#pragma once

#include <QAbstractListModel>

#include "ProductionDatabase.h"
#include "OrderDao.h"
#include "ProductsDao.h"
#include "OrderProduct.h"

class OrderListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int status READ getStatus WRITE setStatus)

public slots:
    void update();

public:
    enum {
        ID_ROLE,
        ID_TABLE_ROLE,
        ID_STATUS_ROLE,
        TOTAL_ROLE
    };

    explicit OrderListModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    int getStatus() const;
    void setStatus(int value);

private:
    int status; // The particular order-status-id this list is linked to
    OrderDao orderDao = OrderDao(ProductionDatabase::getInstance());
    QList<Order> list;
};


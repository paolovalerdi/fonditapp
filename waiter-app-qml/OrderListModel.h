#pragma once
#include "OrderProduct.h"
#include <QAbstractListModel>
#include "OrderDao.h"
#include "ProductionDatabase.h"
#include "ProductsDao.h"
#include "OrderListModelCallback.h"

#include <QAbstractListModel>

class OrderListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(OrderListModelCallback *callback READ getCallback WRITE setCallback)
    Q_PROPERTY(int id_status READ getId_status WRITE setId_status)

public:
    explicit OrderListModel(QObject *parent = nullptr);

enum{
 idOrder, idTable, idStatus, total
};

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
     QHash<int, QByteArray> roleNames() const override;


     OrderListModelCallback *getCallback() const;
     void setCallback(OrderListModelCallback *value);

     int getId_status() const;
     void setId_status(int value);

private:

     OrderListModelCallback * callback;
     QList<Order> list;
     int id_status;
     OrderDao orderdao = OrderDao(ProductionDatabase::getInstance());

};


#pragma once

#include <QAbstractListModel>

#include "ProductionDatabase.h"
#include "OrderDao.h"
#include "ProductsDao.h"
#include "OrderProduct.h"
#include "WaiterBoardMediator.h"
#include "DatabaseObserver.h"
#include "DatabaseSocket.h"

class OrderListModel : public QAbstractListModel, public DatabaseObserver
{
    Q_OBJECT
    Q_PROPERTY(int status READ getStatus WRITE setStatus)
    Q_PROPERTY(WaiterBoardMediator *mediator READ getMediator WRITE setMediator)

public slots:
    void update();
    void softupdate();

public:
    enum {
        ID_ROLE,
        ID_TABLE_ROLE,
        ID_STATUS_ROLE,
        TOTAL_ROLE,
        CALL_ROLE
    };

    explicit OrderListModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    int getStatus() const;
    void setStatus(int value);
    WaiterBoardMediator *getMediator() const;
		void setMediator(WaiterBoardMediator *value);
		void onEventRecieved(QJsonObject event) override;

private:
    int status; // The particular order-status-id this list is linked to
    OrderDao orderDao = OrderDao(ProductionDatabase::getInstance());
    QList<Order> list;
    WaiterBoardMediator* mediator;
};


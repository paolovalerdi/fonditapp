#include "OrderListModel.h"

OrderListModel::OrderListModel(QObject *parent):
    QAbstractListModel(parent), mediator(nullptr)
{
    status = -1;
    DatabaseSocket::getInstance()->addObserver(this);
}

int OrderListModel::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : list.size();
}

QVariant OrderListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) return QVariant();
    if(list.size() > 0)
    {
        auto order = list.at(index.row());
        switch (role) {
        case ID_ROLE:
            return QVariant(order.getId_order());
        case ID_TABLE_ROLE:
            return QVariant(order.getId_table());
        case ID_STATUS_ROLE:
            return QVariant(order.getId_status());
        case TOTAL_ROLE:
            return QVariant(order.getTotal());
        case CALL_ROLE:
            return QVariant(order.getCall_waiter());
        default:
            throw "No such role";
        }
    }
    return QVariant();
}

int OrderListModel::getStatus() const
{
    return status;
}

void OrderListModel::setStatus(int value)
{
    status = value;
    update();
}

WaiterBoardMediator *OrderListModel::getMediator() const
{
    return mediator;
}

void OrderListModel::setMediator(WaiterBoardMediator *value)
{
    mediator = value;
    connect(mediator,
            &WaiterBoardMediator::onBoardUpdated,
            this,
						&OrderListModel::update);
}

void OrderListModel::onEventRecieved(QJsonObject event)
{
	if (event["target"] == "waiter") {
		if (event["key"] == "create_order") {
			if (status == 3) {
				update();
			}
		}
	}
}

QHash<int, QByteArray> OrderListModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[ID_ROLE] = "idOrder";
    names[ID_TABLE_ROLE] = "idTable";
    names[ID_STATUS_ROLE] = "idStatus";
    names[TOTAL_ROLE] = "total";
    names[CALL_ROLE] = "callWaiter";

    return names;
}

void OrderListModel::update()
{
    if (status != -1) {
        beginRemoveRows(QModelIndex(), 0, list.size() - 1);
        endRemoveRows();

        list = orderDao.getOrdersByStatus(status);

        beginInsertRows(QModelIndex(),0, list.size() - 1);
        endInsertRows();
    }
}

void OrderListModel::softupdate()
{
    //
}

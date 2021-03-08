#include "OrderListModel.h"

void OrderListModel::markAsReady(int idOrder)
{
	orderDao.updateOrderIsReady(idOrder, true);
    QJsonObject updateOrderListEvent {
        {"target", "waiter"},
        {"key", "update_orderlist"}
    };
    DatabaseSocket::getInstance()->sendEvent(updateOrderListEvent);
    emit updateProductGrid(list.at(0).getId_order());
	update();
	if (!list.isEmpty()) {
		showEmptyMessage(false);
	} else {
		showEmptyMessage(true);
	}
}

OrderListModel::OrderListModel(QObject *parent):
	QAbstractListModel(parent)
{
	update();
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
			case POSITION_ROLE:
				return QVariant(index.row());
			default:
				throw "No such role";
		}
	}
	return QVariant();
}

void OrderListModel::onEventRecieved(QJsonObject event)
{
    if (event["target"] == "chef") {
        if (event["key"] == "update_queue") {
           update();
           if(list.size()==1){
               showEmptyMessage(false);
               updateProductGrid(list.at(0).getId_order());
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
	names[POSITION_ROLE] = "position";

	return names;
}

void OrderListModel::update()
{
	beginRemoveRows(QModelIndex(), 0, list.size() - 1);
	endRemoveRows();

	list = orderDao.getNotReadyOrders();

	beginInsertRows(QModelIndex(),0, list.size() - 1);
	endInsertRows();
}



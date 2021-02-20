#include "TableListModel.h"

TableListModel::TableListModel(QObject *parent) : QAbstractListModel(parent)
{
	tables = tablesDao.getAllTables();
}

int TableListModel::rowCount(const QModelIndex &parent) const
{
	return parent.isValid() ? 0 : tables.size();
}

QVariant TableListModel::data(const QModelIndex &index, int role) const
{
	if (!index.isValid())
		return QVariant();

	auto table = tables.at(index.row());
	switch (role) {
		case ID_ROLE:
			return QVariant(table.getIdTable());
		case OCUPIED_ROLE:
			return QVariant(table.getOcupied());
	}
	return QVariant();
}

QHash<int, QByteArray> TableListModel::roleNames() const
{
	QHash<int, QByteArray> names;
	names[ID_ROLE] = "idTable";
	names[OCUPIED_ROLE] = "ocupiedTable";
	return names;
}

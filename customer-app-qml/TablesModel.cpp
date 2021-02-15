#include "TablesModel.h"

TablesModel::TablesModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int TablesModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    // FIXME: Implement me!
    return listTables.size();
}

QVariant TablesModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    auto item = listTables.at(index.row());
    switch (role) {
    case idRole:
        return QVariant(item.getIdTable());
    case ocupiedRole:
        return QVariant(item.getOcupied());
    }
    return QVariant();
}

QHash<int, QByteArray> TablesModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[idRole] = "idTable";
    names[ocupiedRole] = "ocupiedTable";
    return names;
}

#ifndef TABLESMODEL_H
#define TABLESMODEL_H

#include <QAbstractListModel>
#include "ProductionDatabase.h"
#include "Tables.h"
#include "TablesDao.h"

class TablesModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit TablesModel(QObject *parent = nullptr);
    enum {idRole,
          ocupiedRole
         };
    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override; 
    QHash<int, QByteArray> roleNames() const override;

private:
    TablesDao tablesDao = TablesDao(ProductionDatabase::getInstance());
    QList<Tables> listTables = tablesDao.getAllTables();
};

#endif // TABLESMODEL_H

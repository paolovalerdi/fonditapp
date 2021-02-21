#pragma once

#include <QAbstractListModel>

#include "Tables.h"
#include "ProductionDatabase.h"
#include "TablesDao.h"

class TableListModel : public QAbstractListModel
{
		Q_OBJECT

	public:
		enum {
			ID_ROLE,
			OCUPIED_ROLE
		};

		explicit TableListModel(QObject *parent = nullptr);
		int rowCount(const QModelIndex &parent = QModelIndex()) const override;
		QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
		QHash<int, QByteArray> roleNames() const override;

	private:
		QList<Tables> tables;
		TablesDao tablesDao = TablesDao(ProductionDatabase::getInstance());
};

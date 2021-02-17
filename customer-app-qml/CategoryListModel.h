#pragma once

#include <QAbstractListModel>
#include <QException>

#include "ProductionDatabase.h"
#include "ProductsDao.h"
#include "Category.h"

class CategoryListModel : public QAbstractListModel
{
  Q_OBJECT

public:
  enum Roles {
    ID_ROLE,
    TITLE_ROLE,
    ICON_ROLE
  };

  explicit CategoryListModel(QObject *parent = nullptr);
  int rowCount(const QModelIndex &parent = QModelIndex()) const override;
  QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
  QHash<int, QByteArray> roleNames() const override;

private:
  QList<Category> categories;
  ProductsDao productDao = ProductsDao(ProductionDatabase::getInstance());

  QString getImagePath(int categoryId) const;
};

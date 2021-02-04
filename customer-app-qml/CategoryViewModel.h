#ifndef CATEGORYVIEWMODEL_H
#define CATEGORYVIEWMODEL_H

#include <QAbstractListModel>
#include <QException>

#include "AbsDatabase.h"
#include "ProductionDatabase.h"
#include "ProductsDao.h"
#include "Category.h"

class CategoryViewModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit CategoryViewModel(QObject *parent = nullptr);

    enum Roles{
        IdRole,
        TitleRole,
        IconRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
private:
    QList<Category> categories;
    ProductsDao productDao = ProductsDao(ProductionDatabase::getInstance());
    QString getImagePath(int categoryId) const;
};

#endif // CATEGORYVIEWMODEL_H

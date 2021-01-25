#ifndef PRODUCTLIST_H
#define PRODUCTLIST_H

#include <QObject>
#include <ProductionDatabase.h>
#include <ProductsDao.h>
#include <QList>

class ProductList : public QObject
{
    Q_OBJECT
public:
    explicit ProductList(QObject *parent = 0);
signals:
    void onCategoryChanged(int id);
public slots:
    void updateCategory(int id);
};

#endif // PRODUCTLIST_H

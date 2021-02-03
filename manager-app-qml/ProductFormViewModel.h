#pragma once

#include <QObject>
#include "ProductsDao.h"
#include "ProductionDatabase.h"

class ProductFormViewModel : public QObject
{
    Q_OBJECT
public:
    explicit ProductFormViewModel(QObject *parent = nullptr);

public slots:
    void updateProduct(int id,
                       QString name,
                       QString description,
                       QString price);
    void deleteProduct(int id);
    void createProduct(QString name,
                       QString description,
                       QString price);
private:

    ProductsDao productsDao = ProductsDao(ProductionDatabase::getInstance());
};

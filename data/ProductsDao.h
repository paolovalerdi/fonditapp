#pragma once

#include "AbsDatabase.h"
#include "Product.h"
#include "Category.h"
#include <QList>
#include <QVariant>

class ProductsDao
{
public:
    ProductsDao(AbsDatabase* database);
    QList<Product> getProductsByCategory(int id);
    void insertProduct(Product product);
    void deleteProduct(Product product);
    /**
     * Actualiza todos los campos, excepto el id
     */
    void updateProduct(Product updatedProduct);
private:
    AbsDatabase* database;
};

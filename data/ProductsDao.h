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
    QList<Product> getAllProducts();
    QList<Category> getAllCategories();
    Product getProductById(int idProduct) const;
    QList<Product> getProductsByCategory(int id);
    void insertProduct(Product product);
    void deleteProduct(int id);
    void updateProduct(int id,
                       QString name,
                       QString description,
                       QString price);
private:
    AbsDatabase* database;
};

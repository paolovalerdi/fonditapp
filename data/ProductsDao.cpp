#include "ProductsDao.h"

ProductsDao::ProductsDao(AbsDatabase* database)
{
    this->database = database;
}

QList<Product> ProductsDao::getAllProducts()
{
    auto results = QList<Product>();
    auto query = database->executeQuery(
                QString("SELECT * FROM products INNER JOIN categories ON products.id_category = categories.id_category"));
    while(query.next()) {
        auto id = query.value("id_product").toInt();
        auto name = query.value("name").toString();
        auto description = query.value("description").toString();
        auto picture = query.value("picture").toByteArray();
        auto price = query.value("price").toDouble();
        auto categoryId = query.value("id_category").toInt();
        auto categoryTitle = query.value("title").toString();
        results.append(Product(id, name, description, price, picture, Category(categoryId, categoryTitle)));
    }
    return results;
}

QList<Product> ProductsDao::getProductsByCategory(int id)
{
    auto results = QList<Product>();
    auto query = database->executeQuery(
                QString("SELECT * FROM products INNER JOIN categories ON products.id_category = categories.id_category WHERE categories.id_category = %1").arg(id));
    while(query.next()) {
        auto id = query.value("id_product").toInt();
        auto name = query.value("name").toString();
        auto description = query.value("description").toString();
        auto picture = query.value("picture").toByteArray();
        auto price = query.value("price").toDouble();
        auto categoryId = query.value("id_category").toInt();
        auto categoryTitle = query.value("title").toString();
        results.append(Product(id, name, description, price, picture, Category(categoryId, categoryTitle)));
    }
    return results;
}

void ProductsDao::insertProduct(Product product)
{
    auto query = database->prepareQuery(QString("INSERT INTO products ")
                                        .append("(name, description, picture, price, id_category)")
                                        .append("VALUES (")
                                        .append(":name, ")
                                        .append(":description, ")
                                        .append(":picture, ")
                                        .append(":price, ")
                                        .append(":id_category)"));
    query.bindValue(":name", product.getName());
    query.bindValue(":description", product.getDescription());
    query.bindValue(":picture", QVariant(product.getPicture()));
    query.bindValue(":price", product.getPrice());
    query.bindValue(":id_category", product.getCategory().getId());
}

void ProductsDao::deleteProduct(Product product)
{
    auto query = database->executeQuery(QString("DELETE FROM products WHERE id_product = %1").arg(product.getId()));
}

#include "ProductsDao.h"
#include "QDebug"

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

QList<Category> ProductsDao::getAllCategories()
{
    auto results = QList<Category>();
    auto query = database->executeQuery("SELECT * FROM categories");
    while (query.next()) {
        results.append(Category(query.value("id_category").toInt(), query.value("title").toString()));
    }
    return results;
}

Product ProductsDao::getProductById(int idProduct) const
{
    auto query = database->executeQuery(
                QString("SELECT * FROM products INNER JOIN categories ON products.id_category = categories.id_category WHERE id_product = %1").arg(idProduct));
   while(query.next())
   {
       auto id = query.value("id_product").toInt();
       auto name = query.value("name").toString();
       auto description = query.value("description").toString();
       auto picture = query.value("picture").toByteArray();
       auto price = query.value("price").toDouble();
       auto categoryId = query.value("id_category").toInt();
       auto categoryTitle = query.value("title").toString();
       return Product(id, name, description, price, picture, Category(categoryId, categoryTitle));
   }

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
    query.exec();
    database->printLastError();
}

void ProductsDao::deleteProduct(int id )
{
    auto query = database->executeQuery(QString("DELETE FROM products WHERE id_product = %1").arg(id));
}

void ProductsDao::updateProduct(int id,
                                QString name,
                                QString description,
                                QString price)
{
    auto query = database->executeQuery(QString("UPDATE products ")
                                        .append("SET name = '%1', ")
                                        .append("description = '%2', ")
                                        .append("price = %3 ")
                                        .append("WHERE id_product = %4")
                                        .arg(name)
                                        .arg(description)
                                        .arg(price.toDouble())
                                        .arg(id));
    database->printLastError();
}


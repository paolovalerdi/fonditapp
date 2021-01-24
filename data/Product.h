#pragma once

#include <QString>
#include "Category.h"

class Product
{
public:
    Product();
    Product(int id,
            QString name,
            QString description,
            double price,
            /*TODO: BLOB*/
            Category category);
    int getId() const;
    QString getDescription() const;
    double getPrice() const;
    Category getCategory() const;

private:
    int id;
    QString name;
    QString description;
    // TODO: BLOB
    double price;
    Category category;

};

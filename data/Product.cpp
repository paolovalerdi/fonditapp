#include "Product.h"

Product::Product()
{
    this->id = -1;
    this->name = "";
    this->description = "";
    this->price = -1;
    this->category = Category();
}

Product::Product(int id, QString name, QString description, double price, QByteArray picture, Category category)
{
    this->id = id;
    this->name = name;
    this->description = description;
    this->price = price;
    this->picture = picture;
    this->category = category;
}

int Product::getId() const
{
    return id;
}

QString Product::getDescription() const
{
    return description;
}

double Product::getPrice() const
{
    return price;
}

Category Product::getCategory() const
{
    return category;
}

QByteArray Product::getPicture() const
{
    return picture;
}

QString Product::getName() const
{
    return name;
}

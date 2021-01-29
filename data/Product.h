#pragma once

#include <QString>
#include <QByteArray>
#include "Category.h"

class Product
{
public:
    Product();
    Product(int id,
            QString name,
            QString description,
            double price,
            QByteArray picture,
            Category category);
    int getId() const;
    QString getDescription() const;
    double getPrice() const;
    Category getCategory() const;
    QByteArray getPicture() const;
    QString getName() const;

private:
    int id;
    QString name;
    QString description;
    QByteArray picture;
    double price;
    Category category;

};

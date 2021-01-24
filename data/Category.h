#pragma once

#include <QString>

class Category
{
public:
    Category();
    Category(int id, QString title);
    int getId() const;
    QString getTitle() const;

private:
    int id;
    QString title;
};

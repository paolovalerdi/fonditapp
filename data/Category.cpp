#include "Category.h"

Category::Category()
{
    this->id = -1;
    this->title = "";
}

Category::Category(int id, QString title)
{
    this->id = id;
    this->title = title;
}

int Category::getId() const
{
    return id;
}

QString Category::getTitle() const
{
    return title;
}

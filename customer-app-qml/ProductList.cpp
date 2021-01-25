#include "ProductList.h"

ProductList::ProductList(QObject *parent) : QObject(parent)
{
}


void ProductList::updateCategory(int id)
{
    emit onCategoryChanged(id);
}

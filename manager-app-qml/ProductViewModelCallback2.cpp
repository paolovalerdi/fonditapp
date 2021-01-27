#include "ProductViewModelCallback2.h"

ProductViewModelCallback2::ProductViewModelCallback2(QObject *parent) : QObject(parent)
{
}


void ProductViewModelCallback2::updateCategory(int id)
{
    emit onCategoryUpdated(id);
}

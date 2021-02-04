#include "ProductViewModelCallback.h"

ProductViewModelCallback::ProductViewModelCallback(QObject *parent) : QObject(parent)
{
}


void ProductViewModelCallback::updateCategory(int id)
{
    emit onCategoryUpdated(id);
}

void ProductViewModelCallback::clearWindow()
{
    emit onStatusSelected();
}

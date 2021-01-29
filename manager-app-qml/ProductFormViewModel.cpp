#include "ProductFormViewModel.h"

ProductFormViewModel::ProductFormViewModel(QObject *parent) : QObject(parent)
{

}

void ProductFormViewModel::updateProduct(int id, QString name, QString description, QString price)
{
    qDebug() << "Ya llegué";
    productsDao.updateProduct(id, name, description, price);
}

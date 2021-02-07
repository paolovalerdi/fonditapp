#include "ProductFormViewModel.h"

ProductFormViewModel::ProductFormViewModel(QObject *parent) : QObject(parent)
{

}

void ProductFormViewModel::updateProduct(int id, QString name, QString description, QString price)
{
    productsDao.updateProduct(id, name, description, price);
}

void ProductFormViewModel::deleteProduct(int id)
{
    productsDao.deleteProduct(id);
}

void ProductFormViewModel::createProduct(QString name, QString description, QString price)
{
    qDebug()<<name;
    qDebug()<<description;
    qDebug()<<price;
    productsDao.insertProduct(Product (-1,name,description,0,QByteArray("hola:c"),Category(3,"")));
}

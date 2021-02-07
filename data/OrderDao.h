#ifndef ORDERDAO_H
#define ORDERDAO_H
#include "AbsDatabase.h"
#include <QVariant>
#include "Product.h"
#include "OrderProduct.h"
#include "ProductsDao.h"
#include <QList>
class OrderDao
{
public:
    OrderDao(AbsDatabase* database);
    int createOrder(int idTable) const;
    void insertIntoOrder(QList<OrderProduct>list, int idOrder) const;
    QList<OrderProduct> getProductsByOrderId(int idOrder) const;
    double calculateTotal(int idOrder) const;
    QString getStatus(int idOrder) const;
private:
    AbsDatabase* database;
     //const ProductsDao productDao;
};
#endif // ORDERDAO_H

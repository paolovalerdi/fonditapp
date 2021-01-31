#ifndef ORDERDAO_H
#define ORDERDAO_H
#include "AbsDatabase.h"
#include <QVariant>
#include "Product.h"
#include "OrderProduct.h"
class OrderDao
{
public:
    OrderDao(AbsDatabase* database);
    int createOrder(int idTable);
    void insertIntoOrder(QList<OrderProduct>list, int idOrder);
private:
    AbsDatabase* database;
};

#endif // ORDERDAO_H

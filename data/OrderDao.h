#ifndef ORDERDAO_H
#define ORDERDAO_H
#include "AbsDatabase.h"
#include <QVariant>
#include "Product.h"
#include "OrderProduct.h"
#include "ProductsDao.h"
#include "Order.h"
#include <QList>
#include <QDateTime>
class OrderDao
{
public:
    OrderDao(AbsDatabase* database);
    int createOrder(int idTable) const;
    void insertIntoOrder(QList<OrderProduct>list, int idOrder) const;
    QList<OrderProduct> getProductsByOrderId(int idOrder) const;
    double calculateTotal(int idOrder) const;
    QString getStatus(int idOrder) const;
    void insertIntoBill(int idOrder) const;
    QList<Order> getOrdersByStatus(int id_s);
    void updateOrderStatus(Order order);
		void updateOrderProductIsReady(int idOrderProduct, int idOrder, bool isReady);
    Order getOrderById(int id);
    void updateRequest(int id) const;
    //bool Request(int id_table) const;
    int getRequest() const;
private:
    AbsDatabase* database;
     //const ProductsDao productDao;
};
#endif // ORDERDAO_H

#ifndef ORDERPRODUCT_H
#define ORDERPRODUCT_H


class OrderProduct
{
public:
    OrderProduct();
    OrderProduct(int idProduct, int quantity,int idOrder);
    OrderProduct(int idProduct, int quantity);
    int getIdProduct() const;
    int getQuantity() const;
    int getIdOrder() const;

    void setIdOrder(int value);

private:
    int idProduct;
    int quantity;
    int idOrder;
};

#endif // ORDERPRODUCT_H

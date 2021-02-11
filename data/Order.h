#ifndef ORDER_H
#define ORDER_H


class Order
{
private:
    int id_order;
    int id_table;
    int id_status;
    double total;

public:
    Order();
    Order(int id_o, int id_t, int id_s,double tot);

    int getId_order() const;
    int getId_table() const;
    int getId_status() const;
    double getTotal() const;
};

#endif // ORDER_H

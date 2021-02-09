#include "Order.h"

int Order::getId_order() const
{
    return id_order;
}

int Order::getId_table() const
{
    return id_table;
}

int Order::getId_status() const
{
    return id_status;
}

double Order::getTotal() const
{
    return total;
}

Order::Order()
{


}

Order::Order(int id_o, int id_t, int id_s, double tot)
{
    this->id_order = id_o;
    this->id_table = id_t;
    this->id_status = id_s;
    this->total = tot;
}
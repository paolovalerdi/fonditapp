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

int Order::getCall_waiter() const
{
    return call_waiter;
}

bool Order::getReady() const
{
	return ready;
}

Order::Order(){}

Order::Order(int id_o, int id_t, int id_s, int c_w,double tot, bool ready)
{
    this->id_order = id_o;
    this->id_table = id_t;
    this->id_status = id_s;
    this->call_waiter=c_w;
    this->total = tot;
	this->ready = ready;
}

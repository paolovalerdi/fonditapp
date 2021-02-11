#include "OrderListModelCallback.h"

OrderListModelCallback::OrderListModelCallback(QObject *parent) : QObject(parent)
{

}

void OrderListModelCallback::requestUpdate()
{
    emit onUpdateRequested();
}

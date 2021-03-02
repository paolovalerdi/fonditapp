#include "ChefMediator.h"

void ChefMediator::markAsReady(int idOrder)
{
	orderDao.updateOrderIsReady(idOrder, true);
	emit onUpdate();
}

ChefMediator::ChefMediator(QObject *parent) : QObject(parent)
{

}

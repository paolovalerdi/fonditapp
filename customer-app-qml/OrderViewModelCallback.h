#ifndef ORDERVIEWMODELCALLBACK_H
#define ORDERVIEWMODELCALLBACK_H

#include <QObject>

class OrderViewModelCallback : public QObject
{
    Q_OBJECT
public:
    explicit OrderViewModelCallback(QObject *parent = nullptr);

signals:
    void onAddProduct(int idProduct,int quantity);
public slots:
    void addProduct(int idProduct,int quantity);

};

#endif // ORDERVIEWMODELCALLBACK_H

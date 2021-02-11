#ifndef ORDERLISTMODELCALLBACK_H
#define ORDERLISTMODELCALLBACK_H

#include <QObject>

class OrderListModelCallback : public QObject
{
    Q_OBJECT
public:
    explicit OrderListModelCallback(QObject *parent = nullptr);
public slots:
    void requestUpdate();
signals:
    void onUpdateRequested();
};

#endif // ORDERLISTMODELCALLBACK_H

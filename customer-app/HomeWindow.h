#ifndef HOMEWINDOW_H
#define HOMEWINDOW_H

#include <QDialog>
#include "ProductsDao.h"
#include "ProductionDatabase.h"

namespace Ui {
class HomeWindow;
}

class HomeWindow : public QDialog
{
    Q_OBJECT

public:
    explicit HomeWindow(QWidget *parent = nullptr);
    ~HomeWindow();

private:
    Ui::HomeWindow *ui;
    ProductsDao productDao = ProductsDao(ProductionDatabase::getInstance());
};

#endif // HOMEWINDOW_H

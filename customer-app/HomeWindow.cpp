#include "HomeWindow.h"
#include "ui_HomeWindow.h"

HomeWindow::HomeWindow(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::HomeWindow)
{

    ui->setupUi(this);
    ui->stackedWidget->setCurrentIndex(1);
    for(auto product : productDao.getProductsByCategory(1)) {
        qDebug() << product.getName();
    }
}

HomeWindow::~HomeWindow()
{
    delete ui;
}

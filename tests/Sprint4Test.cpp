#include "TestDatabase.h"
#include "ProductsDao.h"
#include "Product.h"
#include "ProductionDatabase.h"
#include "AbsDatabase.h"
#include "catch.hpp"

TEST_CASE("GetBill")
{
    TestDatabase db;
    //ProductsDao productDao = ProductsDao(TestDatabase::getInstance());

    auto query=db.executeQuery("Select * from bill where id_order=1");
    QString Fecha;

    while(query.next())
    {
        Fecha=query.value(1).toString();

    }

    qDebug()<<Fecha;
    REQUIRE(Fecha=="9-02-21 3:30:33");


}


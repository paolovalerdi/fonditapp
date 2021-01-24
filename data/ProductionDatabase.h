#pragma once

#include "AbsDatabase.h"
#include <QSqlError>
#include <QDebug>

class ProductionDatabase : public AbsDatabase
{
public:
    static ProductionDatabase& getInstance();
    QSqlQuery executeQuery(QString queryStr) override;
private:
    ProductionDatabase();
    QSqlDatabase* database = nullptr;
};

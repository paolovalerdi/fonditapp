#pragma once

#include "AbsDatabase.h"
#include <QSqlError>
#include <QDebug>

class ProductionDatabase : public AbsDatabase
{
public:
    static ProductionDatabase* getInstance();
    QSqlQuery executeQuery(QString queryStr) override;
    QSqlQuery executeQuery(QSqlQuery queryObj) override;
    QSqlQuery prepareQuery(QString queryString) override;
    void printLastError() override;
protected:
    static ProductionDatabase* instance;
private:
    ProductionDatabase();
    QSqlDatabase database;
};

//ProductionDatabase* ProductionDatabase::instance = nullptr;


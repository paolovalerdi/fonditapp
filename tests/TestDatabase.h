#pragma once

#include "AbsDatabase.h"
#include <QSqlError>
#include <QDebug>

class TestDatabase : public AbsDatabase
{
public:
    TestDatabase();
    QSqlQuery executeQuery(QString queryStr) override;
    QSqlQuery executeQuery(QSqlQuery queryObj) override;
    QSqlQuery prepareQuery(QString queryString) override;
    void printLastError() override;
    void CreateTables();
    void InsertTables();
private:
    QSqlDatabase database;
};

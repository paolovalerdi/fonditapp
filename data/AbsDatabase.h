#pragma once

#include <QSqlQuery>

class AbsDatabase {
public:
    virtual QSqlQuery executeQuery(QString queryStr) = 0;
    virtual QSqlQuery prepareQuery(QString queryString) = 0;
    virtual QSqlQuery executeQuery(QSqlQuery queryObj) = 0;
};

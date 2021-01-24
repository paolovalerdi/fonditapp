#pragma once

#include <QSqlQuery>

class AbsDatabase {
public:
    virtual QSqlQuery executeQuery(QString queryStr) = 0;
};

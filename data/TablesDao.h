#ifndef TABLESDAO_H
#define TABLESDAO_H
#include "AbsDatabase.h"
#include "Tables.h"
#include <QList>
#include <QVariant>

class TablesDao
{
public:
    TablesDao(AbsDatabase* database);
    QList<Tables> getAllTables();
    void updateOcupied(int idTable, bool ocupied);
private:
        AbsDatabase* database;
};

#endif // TABLESDAO_H

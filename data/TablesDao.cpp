#include "TablesDao.h"

TablesDao::TablesDao(AbsDatabase* database)
{
    this->database = database;
}

QList<Tables> TablesDao::getAllTables()
{
    auto results = QList<Tables>();
    auto query = database->executeQuery(
                QString("SELECT * FROM tables"));
    while(query.next()) {
        auto id = query.value("id_table").toInt();
        auto ocupied = query.value("ocupied").toBool();
        results.append(Tables(id,ocupied));
    }
    return results;
}

void TablesDao::updateOcupied(int idTable, bool ocupied)
{
    database->executeQuery(
                   QString("UPDATE tables SET ocupied=%1 WHERE id_table=%2")
                .arg(ocupied)
                .arg(idTable)
                );
}

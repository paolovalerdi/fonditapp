#include "ProductionDatabase.h"

ProductionDatabase &ProductionDatabase::getInstance()
{
    static ProductionDatabase instance;
    return instance;
}

ProductionDatabase::ProductionDatabase()
{
    database = QSqlDatabase::addDatabase("QMYSQL");
    database.setHostName("localhost");
    database.setDatabaseName("fonditapp");
    database.setUserName("root");
    database.setPassword("");
    bool isOpen = database.open();
    if (!isOpen) {
        qDebug() << "[ProductionDatabase] => Couldn´t open database";
        qDebug() << database.lastError().text();
    } else {
        qDebug() << "Connected!";
    }
}

QSqlQuery ProductionDatabase::executeQuery(QString queryStr)
{
    QSqlQuery query(database);
    query.exec(queryStr);
    return query;
}

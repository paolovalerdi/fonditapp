#include "ProductionDatabase.h"

ProductionDatabase &ProductionDatabase::getInstance()
{
    static ProductionDatabase instance;
    return instance;
}

ProductionDatabase::ProductionDatabase()
{
    database = new QSqlDatabase();
    database->addDatabase("QMYSQL");
    database->setHostName("http://127.0.0.1/");
    database->setDatabaseName("fonditapp");
    database->setUserName("root");
    database->setPassword("");
    bool isOpen = database->open();
    if (!isOpen) {
        qDebug() << "[ProductionDatabase] => Couldn´t open database";
        qDebug() << database->lastError().text();
    }
}

QSqlQuery ProductionDatabase::executeQuery(QString queryStr)
{
    QSqlQuery query(*database);
    query.exec(queryStr);
    return query;
}

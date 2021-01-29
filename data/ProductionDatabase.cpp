#include "ProductionDatabase.h"

ProductionDatabase* ProductionDatabase::instance = nullptr;

ProductionDatabase* ProductionDatabase::getInstance()
{
    if (instance == nullptr) {
        instance = new ProductionDatabase();
    }
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
    return executeQuery(prepareQuery(queryStr));
}

QSqlQuery ProductionDatabase::executeQuery(QSqlQuery queryObj)
{
    queryObj.exec();
    return queryObj;
}

QSqlQuery ProductionDatabase::prepareQuery(QString queryString)
{
    QSqlQuery query(database);
    query.prepare(queryString);
    return query;
}

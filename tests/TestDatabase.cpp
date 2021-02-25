#include "TestDatabase.h"

TestDatabase::TestDatabase()
{
    QSqlDatabase::removeDatabase("TEST_CONNECTION");
    database = QSqlDatabase::addDatabase("QSQLITE","TEST_CONNECTION");
    database.setDatabaseName(":memory:");
    bool isOpen = database.open();
    if (!isOpen) {
        qDebug() << "[ProductionDatabase] => Couldn´t open database";
        qDebug() << database.lastError().text();
    } else {
        qDebug() << "Connected!";
       CreateTables();
       InsertTables();
    }
}

QSqlQuery TestDatabase::executeQuery(QString queryStr)
{
    return executeQuery(prepareQuery(queryStr));
}

QSqlQuery TestDatabase::executeQuery(QSqlQuery queryObj)
{
    queryObj.exec();
    return queryObj;
}

QSqlQuery TestDatabase::prepareQuery(QString queryString)
{
    QSqlQuery query(database);
    query.prepare(queryString);
    return query;
}

void TestDatabase::printLastError()
{
    qDebug()<<database.lastError();
}

void TestDatabase::CreateTables()
{
    database.exec(QString("CREATE TABLE categories ( id_category int(11) PRIMARY KEY NOT NULL , title varchar(250) NOT NULL);")
                  );

    database.exec(QString("CREATE TABLE products ( id_product int(11) PRIMARY KEY NOT NULL , name varchar(250) NOT NULL,")
               .append("description varchar(500) NOT NULL,")
               .append("picture longblob DEFAULT NULL,")
               .append("price double NOT NULL,")
               .append("id_category int(11) NOT NULL,")
               .append("FOREIGN KEY(id_category) REFERENCES categories(id_category) );")
                  );


    database.exec(QString("CREATE TABLE tables (id_table int(11) PRIMARY KEY NOT NULL,ocupied tinyint(1) NOT NULL,request tinyint(1)NOT NULL DEFAULT 0);"));

    database.exec(QString("CREATE TABLE order_status (id_status int(11) PRIMARY KEY NOT NULL,name varchar(100) NOT NULL);")
                  );

    database.exec(QString("CREATE TABLE orders(")
                  .append("id_order int(11) NOT NULL,")
                  .append("id_table int(11) NOT NULL,")
                  .append("id_status int(11) NOT NULL DEFAULT 3,")
                  .append("FOREIGN KEY(id_table) REFERENCES tables(id_table) ,")
                  .append("FOREIGN KEY(id_status) REFERENCES order_status(id_status) );")
                  );

    database.exec(QString("CREATE TABLE order_products (id_product int(11) NOT NULL, quantity int(11),  id_order int(11) ,")
                    .append("FOREIGN KEY(id_product) REFERENCES products(id_product),")
                    .append("FOREIGN KEY(id_order) REFERENCES orders(id_order) );")
                  );

    database.exec(QString("CREATE TABLE bill (id_order int(11), date datetime,")
                    .append("FOREIGN KEY(id_order) REFERENCES orders(id_order) );")
                  );

}


void TestDatabase::InsertTables()
{

    database.exec(QString("INSERT INTO categories (id_category, title) VALUES")
                  .append("(1, 'Bebidas'),")
                  .append("(2, 'Entradas'),")
                  .append("(3, 'Plato fuerte'),")
                  .append("(4, 'Postres'),")
                  .append("(5, 'Otros');")
                  );

    database.exec(QString("INSERT INTO tables (id_table, ocupied,request) VALUES")
                  .append("(1,0,1),")
                  .append("(2,0,0),")
                  .append("(3,0,0),")
                  .append("(4,0,0);")
                  );

    database.exec(QString("INSERT INTO products (id_product, name, description, price, id_category) VALUES")
                  .append("(1, 'Sopes', '3 Deliciosos sopes con carne asada estilo Chihuhua',25, 2),")
                  .append("(2, 'Helado Oreo', 'Delicioso helado oreo acompañado de galletas saladitas',25, 4),")
                  .append("(3, 'Cafe', 'Taza de cafe tradicional',20, 1),")
                  .append("(4, 'Chiles rellenos', '3 Chiles rellenos al gusto: picadillo,pollo,atún',40, 3),")
                  .append("(5, 'Quesadillas', '3 Quesadillas a escoger: quesillo, pollo , jamon',30, 5);")
                  );
    database.lastError();


    database.exec(QString("INSERT INTO order_status (id_status, name) VALUES")
                  .append("(3, 'Pendiente'),")
                  .append("(4, 'En progreso'),")
                  .append("(5, 'Entregada');")
                  );



    database.exec(QString("INSERT INTO orders (id_order, id_table, id_status) VALUES")
                  .append("(1,1,3),")
                  .append("(2,2,5);")
                  );


    database.exec(QString("INSERT INTO order_products (id_product, quantity, id_order) VALUES")
                  .append("(1,2,1),")
                  .append("(3,2,1),")
                  .append("(2,3,1),")
                  .append("(5,3,2),")
                  .append("(4,1,2);")
                  );

    database.exec(QString("INSERT INTO bill (id_order, date) VALUES")
                  .append("(1,'9-02-21 3:30:33');")
                  );


}

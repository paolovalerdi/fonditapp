#ifndef TABLES_H
#define TABLES_H


class Tables
{
public:
    Tables();
    Tables(int idTable,bool ocupied);
    int getIdTable() const;
    bool getOcupied() const;

private:
    int idTable;
    bool ocupied;
};

#endif // TABLES_H

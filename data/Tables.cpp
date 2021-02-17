#include "Tables.h"

Tables::Tables()
{

}

Tables::Tables(int idTable, bool ocupied)
{
 this->idTable = idTable;
 this->ocupied = ocupied;
}

int Tables::getIdTable() const
{
    return idTable;
}

bool Tables::getOcupied() const
{
    return ocupied;
}

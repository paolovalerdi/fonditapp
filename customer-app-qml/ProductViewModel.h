#pragma once

#include <QAbstractListModel>
#include "ProductViewModelCallback.h"
#include "ProductionDatabase.h"
#include "ProductsDao.h"

/**
 * Esta clase sirve como un "modelo"
 * entre nuesta vista en QML y nuestros modelo
 * Product de la base de datos.
 * Basicamente se encarga de mapear un Product
 * a algo que QML pueda utilizar.
 * También se encarga de actualizar la lista según el id especificado
 * al recibir la señal proviniente de ProductViewModelCallback
 */
class ProductViewModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(ProductViewModelCallback *callback READ getCallback WRITE setCallback)

public:
    /**
     * Este enum se encarga de definir "roles"
     * en este caso definimos tres roles para
     * tres atributos de Product
     */
    enum {
        NameRole,
        PriceRole,
        PictureRole
    };
    explicit ProductViewModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    /**
     * Una vez mapeados por roleNames, aquí definimos qué
     * información asignar a dichos roles (enum) según el indice actual
     * es decir si tenemos
     * [0] => Product [ name = "Chalupas", price = 5, picture = "0x1111"]
     *
     * Entonces debemos obtener el elemento en nuestra lista productList que esté
     * en el indice @param index y mapear los roles a los valores de Product
     * por ejemplo
     * NameRole => product.name;
     */
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    /**
     * Aquí nos encargamos de mapear los roles
     * a atributos que se puden usar en QML
     * es decir
     * NameRole -> name
     */
    QHash<int, QByteArray> roleNames() const override;


    ProductViewModelCallback *getCallback() const;
    void setCallback(ProductViewModelCallback *value);

private:
    ProductsDao productDao = ProductsDao(ProductionDatabase::getInstance());
    QList<Product> productList = productDao.getAllProducts();
    ProductViewModelCallback *callback;
};

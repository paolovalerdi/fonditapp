#pragma once

#include <QObject>

/**
 * Sirve como un puente entre ProductViewModel y la interfaz
 * descrita en QML.
 */
class ProductViewModelCallback2 : public QObject
{
    Q_OBJECT
public:
    explicit ProductViewModelCallback2(QObject *parent = 0);
signals:
    void onCategoryUpdated(int id);
public slots:
    /**
     * Esta función es la que se llama desde QML
     * la única responsabilidad de está función
     * es emitir la señal onCategoryUpdated
     * esa señal luego es recibida por ProdoctViewModel
     * @param id El id de la categoría
     */
    void updateCategory(int id);
};

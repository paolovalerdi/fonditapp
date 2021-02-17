#include "CategoryListModel.h"

CategoryListModel::CategoryListModel(QObject *parent): QAbstractListModel(parent)
{
    categories.append(Category(-1, "Todo"));
    categories.append(productDao.getAllCategories());
    categories.append(Category(-2, "Seguir Orden"));
}

int CategoryListModel::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : categories.size();
}

QVariant CategoryListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
    {
        return QVariant();
    }

    auto category = categories.at(index.row());
    switch (role) {
    case ID_ROLE:
        return QVariant(category.getId());
    case TITLE_ROLE:
        return QVariant(category.getTitle());
    case ICON_ROLE:
        return QVariant(getImagePath(category.getId()));
    default:
        throw QString("CategoryViewModel: No value for role");
    }
}

QHash<int, QByteArray> CategoryListModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[ID_ROLE] = "categoryId";
    names[TITLE_ROLE] = "title";
    names[ICON_ROLE] = "iconPath";
    return names;
}

QString CategoryListModel::getImagePath(int categoryId) const
{
    switch (categoryId) {
    case -2:
        return QString("../icons/ic_receipt.svg");
    case -1:
        return QString("../icons/ic_menu_book.svg");
    case 1:
        return QString("../icons/ic_bebidas.svg");
    case 2:
        return QString("../icons/ic_entradas.svg");
    case 3:
        return QString("../icons/ic_plato_fuerte.svg");
    case 4:
        return QString("../icons/ic_postres.svg");
    case 5:
        return QString("../icons/ic_otros.svg");
    default:
        throw QString("CategoryViewModel: No icon defined for category with id: %1").arg(categoryId);
    }
}

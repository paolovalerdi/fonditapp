#include "CategoryViewModel.h"

CategoryViewModel::CategoryViewModel(QObject *parent)
    : QAbstractListModel(parent)
{
    categories.append(Category(-1, "Todo"));
    categories.append(productDao.getAllCategories());
    categories.append(Category(-2, "Seguir Orden"));
}

int CategoryViewModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return categories.size();
}

QVariant CategoryViewModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
    {
        return QVariant();
    }
    auto category = categories.at(index.row());
    switch (role) {
    case IdRole:
        return QVariant(category.getId());
    case TitleRole:
        return QVariant(category.getTitle());
    case IconRole:
        return QVariant(getImagePath(category.getId()));
    default:
        throw QString("CategoryViewModel: No value for role");
    }
}

QHash<int, QByteArray> CategoryViewModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[IdRole] = "categoryId";
    names[TitleRole] = "title";
    names[IconRole] = "iconPath";
    return names;
}

QString CategoryViewModel::getImagePath(int categoryId) const
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

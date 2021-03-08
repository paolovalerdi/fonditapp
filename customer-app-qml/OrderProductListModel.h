#pragma once

#include <QAbstractListModel>

#include "Product.h"
#include "OrderProduct.h"
#include "OrderMediator.h"

class OrderProductListModel : public QAbstractListModel
{
		Q_OBJECT
		Q_PROPERTY(OrderMediator *mediator READ getMediator WRITE setMediator)
 public slots:
	public:
		enum {
			ID_ROLE,
			NAME_ROLE,
			DESCRIPTION_ROLE,
			PICTURE_ROLE,
			PRICE_ROLE,
			QUANTITY_ROLE,
            READY_ROLE,
		};

		explicit OrderProductListModel(QObject *parent = nullptr);
		int rowCount(const QModelIndex &parent = QModelIndex()) const override;
		QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
		QHash<int, QByteArray> roleNames() const override;
		OrderMediator* getMediator() const;
		void setMediator(OrderMediator* value);

	private:
		OrderMediator *mediator;
};


#pragma once

class OrderProduct
{
	public:
		OrderProduct(int idProduct = -1, int quantity = 1, int idOrder = -1);
		int getIdProduct() const;
		int getQuantity() const;
		int getIdOrder() const;
		bool operator ==(const OrderProduct& other) const;
		bool operator !=(const OrderProduct& other) const;

	private:
		int idProduct;
		int quantity;
		int idOrder;
};

# カートに入っている商品を表すテーブル
class LineItem < ApplicationRecord
    belongs_to :order, optional: true
    belongs_to :product
    belongs_to :cart, optional: true

    def total_price
        product.price * quantity
    end

    def decrement_item
        self.quantity -= 1
        self.update(quantity: quantity)
        self.quantity
    end
end

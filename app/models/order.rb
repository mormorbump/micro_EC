class Order < ApplicationRecord
    has_many :line_items, dependent: :destroy
    PAYMENT_TYPES = ["現金", "クレジットカード", "注文書"]

    def add_line_items_from_cart(cart)
        # カートを削除した時に品目が連動して破棄されるのを防ぐため、nilに変更。
        # そして
        cart.line_items.each do |item|
            item.cart_id = nil
            # これは要するに
            # order.line_items << item
            # というのと同じこと。
            # line_item.order_id = order.idとかはいらない。
            line_items << item
        end
    end
end

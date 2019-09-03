class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy

    def add_product(product_id)
        product = Product.find(product_id)
        current_item = line_items.find_by(product_id: product.id)
        # binding.pry
        if current_item
            current_item.quantity += 1
            current_item.price = 0 if current_item.price.nil?
            current_item.price += product.price
        else
            current_item = line_items.build(product_id: product.id)
            current_item.price = product.price
        end
        current_item
    end

    def delete_product(product)
        current_item = LineItem.find {|item| item.product == product}
        if current_item.decrement_item <= 0
            current_item.delete
        end
    end

    def total_price
        # LineItemモデルのtotal_priceメソッドをそれぞれに適用
        line_items.to_a.sum{ |item| item.total_price }
    end
end

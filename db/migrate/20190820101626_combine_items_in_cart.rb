class CombineItemsInCart < ActiveRecord::Migration[5.2]
  def up
    # カート内に一つの商品に対して複数の品目があった場合は、一つの品目に置き換える。
    Cart.all.each do |cart|
      # product_idでグルーピングし、それぞれの商品ごとの総数を配列に格納。
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        # product_idに対応した数量が1より多い場合、重複してしまっているので整理
        if quantity > 1
          # ひも付きを解くため、一旦全部削除
          cart.line_items.where(product_id: product_id).delete_all
          # 対応したquantityを代入し生成し直し。
          cart.line_items.create(product_id: product_id, quantity: quantity)
        end
      end
    end
  end

  def down
    # 数量が2以上の品目を複数の品目に分割
    LineItem.where("quantity > 1").each do |line_item|
      # 個別の品目に分割し追加
      line_item.quantity.times do
        LineItem.create(cart_id: line_item.cart_id,
          product_id: line_item.product_id, quantity: 1)
      end
      line_item.destroy
    end
  end
end

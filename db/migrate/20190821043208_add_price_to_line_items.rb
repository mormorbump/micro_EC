class AddPriceToLineItems < ActiveRecord::Migration[5.2]
  def change
    # 有効桁数8桁、小数点第2位
    add_column :line_items, :price, :decimal, precision: 8, scale: 2
  end
end

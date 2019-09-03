# 支払いする顧客との対話用のコントローラ
class StoreController < ApplicationController
  skip_before_action :authorize
  
  def index
    @count = current_counter
    # orderメソッドで商品名の降順で表示
    @products = Product.order(:title)
    @cart = current_cart
  end
end

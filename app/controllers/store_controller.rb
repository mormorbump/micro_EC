# 支払いする顧客との対話用のコントローラ
class StoreController < ApplicationController
  skip_before_action :authorize
  
  def index
    if params[:set_locale]
      redirect_to root_path(locale: params[:set_locale])
    else
      @count = current_counter
      # orderメソッドで商品名の降順で表示
      @products = Product.order(:title)
      @cart = current_cart
    end
  end
end

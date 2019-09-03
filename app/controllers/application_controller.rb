class ApplicationController < ActionController::Base
    before_action :authorize
    before_action :set_i18n_locale_from_params

    private
        def current_cart
            Cart.find(session[:cart_id])
        # 存在しなかった場合新規作成
        rescue ActiveRecord::RecordNotFound
            cart = Cart.create
            session[:cart_id] = cart.id
            cart
        end

        def current_counter
            if session[:counter].nil?
                session[:counter] = 1
            else
                session[:counter] += 1
            end
            session[:counter]
        end

        def authorize
            redirect_to login_url, notice: "ログインしてください。" unless User.find_by(id: session[:user_id])
        end

        def set_i18n_locale_from_params
            if params[:locale]
                if I18n.available_locales.include?(params[:locale].to_sym)
                    I18n.locale = params[:locale]
                else
                    flash.now[:notice] = "#{params[:locale]} translation not available"
                    logger.error flash.now[:notice]
                end
            end
        end

        # ロケールの指定がないときにデフォルトのロケールを値としたURLオプションのハッシュを返す。
        # ロケールの指定がないviewでロケールを指定したページへのリンクを生成するときに利用。
        def default_url_options
            { locale: I18n.locale }
        end
end

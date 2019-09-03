class SessionsController < ApplicationController
  skip_before_action :authorize
 
  "
管理者向けのログイン機能とは
・管理者がユーザ名とパスワードを入力するためのフォームを提供すること
・ログインが完了した時点から、セッション終了時（またはログアウト時）まで、その管理者がログイン済みであるという情報を何らかの方法で保持すること
・アプリケーションの管理部分へのアクセスを制限して、ログイン済みの管理者以外はオンラインストアの管理機能を使用できないようにすること
  "

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    # has_secure_passwordで定義されるauthenticateメソッド。formから送られて来た値をハッシュ化し、password_digestと照合する。
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: "無効なユーザー / パスワードの組み合わせです。"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "ログアウト"
  end
end

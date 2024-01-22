class Admin::SessionsController < ApplicationController
  def create
    admin = Administrator.find_by(login_name: params[:login_name])
    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to :admin_root
    else
      flash.alert = "名前とパスワードが一致していません。"
      redirect_to :admin_login
    end
  end

  def destroy
    session.delete(:admin_id)
    redirect_to :admin_login, notice: "ログアウトしました。"
  end
end

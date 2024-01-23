class SessionsController < ApplicationController
  def create
    customer = Customer.find_by(login_name: params[:login_name])
    if customer&.authenticate(params[:password])
      session[:customer_id] = customer.id
      redirect_to :root
    else
      flash.alert = "名前とパスワードが一致していません。"
      redirect_to :login_customers
    end
  end

  def destroy
    session.delete(:customer_id)
    redirect_to :root, notice: "ログアウトしました。"
  end
end

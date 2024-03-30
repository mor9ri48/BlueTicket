class CustomersController < ApplicationController
  def new
    @customer = Customer.new(birthday: Date.new(1980, 1, 1))
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      session[:customer_id] = @customer.id
      redirect_to :root, notice: "会員を登録しました。"
    else
      render "new"
    end
  end

  def destroy
    @customer = current_customer
    if @customer
      @customer.destroy
      redirect_to :root, notice: "アカウントを削除しました。"
    else
      redirect_to :root, notice: "既にアカウントが削除されています。"
    end
  end
end

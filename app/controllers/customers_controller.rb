class CustomersController < ApplicationController
  def new
    @customer = Customer.new(birthday: Date.new(1980, 1, 1))
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      redirect_to :root, notice: "アカウントを登録しました。"
    else
      render "new"
    end
  end

  def destroy
    @customer = current_customer
    @customer.destroy
    redirect_to :root, notice: "アカウントを削除しました。"
  end
end

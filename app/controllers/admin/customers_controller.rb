class Admin::CustomersController < Admin::Base
  def index
    @customers = Customer.order(params[:id])
    params[:sex] == 0
  end

  def search
    @customers = Customer.search(params[:q], params[:sex])
    render "index"
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer
      @customer.destroy
      redirect_to :admin_customers, notice: "アカウントを削除しました。"
    else
      redirect_to :admin_customers, notice: "既にアカウントが削除されています。"
    end
  end
end

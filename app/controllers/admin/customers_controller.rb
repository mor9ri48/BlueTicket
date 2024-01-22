class Admin::CustomersController < Admin::Base
  before_action :admin_login_required

  def index
    @customers = Customer.order(params[:id])
  end

  def search
    @customers = Customer.search(params[:q])
    render "index"
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to :admin_customers, notice: "顧客を削除しました。"
  end
end

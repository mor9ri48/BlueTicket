class Airline::FlightsController < Airline::Base
  before_action :airline_login_required

  def index
    @flights = Flight.order(params[:id])
  end

  def show
    @flight = Flight.find(params[:id])
  end

  def new
    @flight = Flight.new
  end

  def create
    @flight = Flight.new(params[:flight])
    if @flight.save
      redirect_to [:airline, @flight], notice: "便を登録しました。"
    else
      render "new"
    end
  end

  #便の操作
  def update
    @flight = Flight.find(params[:id])
    if @flight.operation # 運航→欠航
      @flight.operation = false
      if @flight.save
        redirect_to [:airline, @flight], notice: "便を欠航にしました。"
      end
    end
  end

end

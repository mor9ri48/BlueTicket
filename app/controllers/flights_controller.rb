class FlightsController < ApplicationController
  def index
    @flights = Flight.order("id")
  end

  def show
    @flight = Flight.find(params[:id])
  end

  def search
    if params[:origin].to_i == 0 || params[:destination].to_i == 0
      redirect_to request.referer, notice: "出発地と到着地を指定してください。"
    elsif params[:origin] == params[:destination]
      redirect_to request.referer, notice: "出発地と到着地が重複していないように指定してください。"
    elsif "#{params[:date]} #{params[:time]}" < "#{Time.current}"
      redirect_to request.referer, notice: "今日以降の日時を指定してください。"
    elsif params[:minPrice] > params[:maxPrice]
      redirect_to request.referer, notice: "左側に下限料金を、右側に上限金額を指定してください。"
    else
      @flights = Flight.search(params[:origin], params[:destination], params[:date], params[:time],
         params[:movement], params[:seatClass], params[:minPrice], params[:maxPrice])
      render "index"
    end
  end
end
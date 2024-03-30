class FlightsController < ApplicationController
  def index
    @flights = Flight.order("id").page(params[:page]).per(100)
    params[:airline] = 0
    params[:date] = {date: Date.current}
    params[:time] = {time: Time.current.strftime("%H:%M")}
    params[:movement] = "出発"
    params[:seat_class] = "no_design"
  end

  def search
    if params[:origin].to_i == 0 || params[:destination].to_i == 0
      redirect_to request.referer, notice: "出発地と到着地を指定してください。"
    elsif params[:origin] == params[:destination]
      redirect_to request.referer, notice: "出発地と到着地が重複していないように指定してください。"
    elsif "#{params[:date][:date]} #{params[:time][:time]}" < "#{Time.current}"
      redirect_to request.referer, notice: "現在以降の日時を指定してください。"
    elsif params[:minPrice].to_i > params[:maxPrice].to_i
      redirect_to request.referer, notice: "左側に下限料金を、右側に上限金額を指定してください。"
    else
      @flights = Flight.search(params[:origin], params[:destination], params[:date], params[:time],
         params[:movement], params[:seat_class], params[:minPrice], params[:maxPrice]).page(params[:page]).per(100)
      render "index"
    end
  end
end
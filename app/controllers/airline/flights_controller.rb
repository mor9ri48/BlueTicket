class Airline::FlightsController < Airline::Base
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

  def show
    @flight = Flight.find(params[:id])
    @airmodel = @flight.airmodel
    @airline = @flight.airline
  end

  def wholeCheckin
    @flight = Flight.find(params[:id])
    @airmodel = @flight.airmodel
    @airline = @flight.airline
  end

  def new
    @flight = Flight.new
  end

  def create
    @flight = Flight.new(params[:flight])
    if "#{params[:departure_date]} #{params[:departure_time]}" == "#{params[:arrival_date]} #{params[:arrival_time]}"
      redirect_to request.referer, notice: "出発日時と到着日時が同時刻です。指定し直してください。"
    elsif @flight.save
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
    else
      redirect_to [:airline, @flight], notice: "既に便は欠航で設定されています。"
    end
  end

end

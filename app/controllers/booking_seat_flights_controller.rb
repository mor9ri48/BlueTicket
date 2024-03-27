class BookingSeatFlightsController < ApplicationController
  before_action :customer_login_required

  # 予約時の座席情報の登録
  def seatChoice
    @flight = Flight.find(params[:flight_id])
    @airmodel = Airmodel.find_by(id: @flight.airmodel.id)
    @airline = Airline.find_by(id: @flight.airline.id)
  end

  # 予約時の搭乗者の登録
  def new
    @flight = Flight.find(params[:flight_id])
    @airmodel = Airmodel.find_by(id: @flight.airmodel.id)
    @booking_seat_flight = BookingSeatFlight.new
    # 座席選択の条件を指定
    if params[:passenger_seat].length < params[:number_of_passengers].to_i
      redirect_to request.referer, notice: "人数に対して選択した座席が少ないです。再度、座席を選択してください。"
    elsif params[:passenger_seat].length > params[:number_of_passengers].to_i
      redirect_to request.referer, notice: "人数に対して選択した座席が多いです。再度、座席を選択してください。"
    elsif Seat.find_by(airmodel_id: @airmodel.id, number: params[:passenger_seat][0]).seat_class != params[:seat_class]
      redirect_to request.referer, notice: "選択した席の一部がクラス対象外の座席です。再度、座席を選択してください。"
    elsif params[:number_of_passengers].to_i >= 2 && (Seat.find_by(airmodel_id: @airmodel.id, number: params[:passenger_seat][1]).seat_class != params[:seat_class])
      redirect_to request.referer, notice: "選択した席の一部がクラス対象外の座席です。再度、座席を選択してください。"
    elsif params[:number_of_passengers].to_i == 3 && (Seat.find_by(airmodel_id: @airmodel.id, number: params[:passenger_seat][2]).seat_class != params[:seat_class])
      redirect_to request.referer, notice: "全席がクラス対象外の座席です。再度、座席を選択してください。"
    end
    common_message = "搭乗者情報について"
    error_message = "・電話番号は、8文字以上15文字以下で、入力してください"
  end

  # 予約時の搭乗者の登録
  def create
    errors_flag = false
    @customer = Customer.find(current_customer.id)
    @flight = Flight.find(params[:flight_id])
    @airmodel = @flight.airmodel
    @booking = Booking.create(customer_id: @customer.id, flight_id: @flight.id, total_price: params[:total_price], payment_method: params[:payment_method])
    @booking_seat_flights = Array.new(params[:number_of_passengers].to_i)
    error_numbers = Array.new
    for number in 0..params[:number_of_passengers].to_i-1 do
      @seat = Seat.find_by(airmodel_id: params[:airmodel_id].to_i, number: params[:passenger_seat][number], seat_class: params[:seat_class])
      @booking_seat_flight = BookingSeatFlight.create(booking_id: @booking.id, flight_id: @flight.id, seat_id: @seat.id,
        passenger_name: params[:passenger_name][number], passenger_birthday: params[:passenger_birthday][number],
        passenger_email: params[:passenger_email][number], passenger_telephone_number: params[:passenger_telephone_number][number],  checkin: false)
      @booking_seat_flights[number] = @booking_seat_flight
    end
    for number in 0..params[:number_of_passengers].to_i-1 do
      if @booking_seat_flights[number].errors.present?
        errors_flag = true
        error_numbers.push(number+1)
      end
    end
    error_message = ""
    # 搭乗者1名の場合
    if params[:number_of_passengers].to_i == 1
      if errors_flag
        errors_flag = false
        error_numbers.each do |error_number|
          error_message = error_message + "搭乗者#{error_number}について<br>"
          @booking_seat_flights[error_number-1].errors.full_messages.each do |message|
            error_message = error_message + "・" + message + "<br>"
          end
        end
        @booking.destroy
        redirect_to request.referer, notice: "搭乗者情報の入力エラーがあります<br>#{error_message}"
      elsif @booking.save && @booking_seat_flight.save
        redirect_to [@customer, :bookings], notice: "便を予約しました。"
      end
    # 搭乗者2名の場合
    elsif params[:number_of_passengers].to_i == 2
      if params[:passenger_seat][0] == params[:passenger_seat][1]
        redirect_to request.referer, notice: "同じ座席を選択しています。再度、座席を選択してください。"
      elsif errors_flag 
        errors_flag = false
        error_numbers.each do |error_number|
          error_message = error_message + "搭乗者#{error_number}について<br>"
          @booking_seat_flights[error_number-1].errors.full_messages.each do |message|
            error_message = error_message + "・" + message + "<br>"
          end
        end
        @booking.destroy
        redirect_to request.referer, notice: "搭乗者情報の入力エラーがあります<br>#{error_message}"
      elsif @booking.save && @booking_seat_flight.save
        redirect_to [@customer, :bookings], notice: "便を予約しました。"
      end
    # 搭乗者3名の場合
    elsif params[:number_of_passengers].to_i == 3
      if params[:passenger_seat][0] == params[:passenger_seat][1]
        redirect_to request.referer, notice: "同じ座席を選択しています。再度、座席を選択してください。"
      elsif params[:passenger_seat][0] == params[:passenger_seat][2]
        redirect_to request.referer, notice: "同じ座席を選択しています。再度、座席を選択してください。"
      elsif params[:passenger_seat][1] == params[:passenger_seat][2]
        redirect_to request.referer, notice: "同じ座席を選択しています。再度、座席を選択してください。"
      elsif errors_flag 
        errors_flag = false
        error_numbers.each do |error_number|
          error_message = error_message + "搭乗者#{error_number}について<br>"
          @booking_seat_flights[error_number-1].errors.full_messages.each do |message|
            error_message = error_message + "・" + message + "<br>"
          end
        end
        @booking.destroy
        redirect_to request.referer, notice: "搭乗者情報の入力エラーがあります<br>#{error_message}"
      elsif @booking.save && @booking_seat_flight.save
        redirect_to [@customer, :bookings], notice: "便を予約しました。"
      end
    end
  end

  # チェックイン
  def update
    @customer = Customer.find(current_customer.id)
    @booking = Booking.find(params[:id])
    @seat = Seat.find_by(airmodel_id: params[:airmodel_id], number: params[:seat_number])
    @booking_seat_flight = BookingSeatFlight.find_by(booking_id: @booking.id, seat_id: @seat.id)
    unless @booking_seat_flight.checkin
      @booking_seat_flight.checkin = true
      if @booking_seat_flight.save
        redirect_to [@customer, @booking], notice: "チェックインが完了しました。"
      else
        redirect_to [@customer, @booking], notice: "チェックインができませんでした。"
      end
    end
  end
end

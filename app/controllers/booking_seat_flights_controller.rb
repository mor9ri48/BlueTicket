class BookingSeatFlightsController < ApplicationController
  

  # 予約時の搭乗者の登録
  def new
    @flight = Flight.find(params[:flight_id])
    @booking_seat_flight = BookingSeatFlight.new
  end
  # 予約時の搭乗者の登録
  def create
    @customer = Customer.find(current_customer.id)
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.create(customer_id: @customer.id, flight_id: @flight.id, total_price: params[:total_price].to_i, payment_method: params[:payment_method])
    for number in 1..params[:number_of_passengers].to_i do
      @booking_seat_flight[number] = BookingSeatFlight.create(booking_id: @booking.id, flight_id: @flight.id, seat_id: params[:seat_id][number].to_i,
        passenger_name: params[:passenger_name][number], passenger_birthday: params[:passenger_birthday][number], passenger_email: params[:passenger_email][number],
          passenger_telephone_number: params[:passenger_telephone_number][number], checkin: false)
    end
    if @booking.save && @booking_seat_flight.save
      redirect_to [@customer, :bookings], notice: "便を予約しました。"
    else
      render "new"
    end
  end 
  # チェックイン
  def update
    @customer = Customer.find(current_customer.id)
    @booking_seat_flight = BookingSeatFlight.find(params[:id])
    @booking = Booking.find(@booking_seat_flight.id)
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

class BookingsController < ApplicationController
  before_action :customer_login_required

  def index
    @customer = Customer.find(params[:customer_id])
    @bookings = @customer.bookings
     # 予約履歴/予約状況の一覧を表示
    if params[:commit] == "予約履歴の確認"
      past_bookings = Array.new
      @bookings.each do |booking|
        flight = Flight.find_by(id: booking.flight_id)
        if Time.parse("#{flight.departure_date} #{flight.departure_time}") <= "#{Time.current}"
          past_bookings.push(booking)
        end
      end
      @bookings = past_bookings
    else
      now_bookings = Array.new
      @bookings.each do |booking|
        flight = Flight.find_by(id: booking.flight_id)
        if Time.parse("#{flight.departure_date} #{flight.departure_time}") > "#{Time.current}"
          now_bookings.push(booking)
        end
      end
      @bookings = now_bookings
    end
  end

  def show
    @customer = Customer.find(params[:customer_id])
    @booking = Booking.find(params[:id])
    @flight = @booking.flight
    @airmodel = @flight.airmodel
    @booking_seat_flights = BookingSeatFlight.where(booking_id: @booking.id, flight_id: @flight.id)
  end

  def checkin
    @customer = Customer.find(params[:customer_id])
    @booking = Booking.find(params[:id])
  end

  def destroy
    @customer = Customer.find(current_customer.id)
    @booking = Booking.find_by(id: params[:id])
    if @booking
      @booking.destroy
      redirect_to [@customer, :bookings], notice: "予約を取り消しました。"
    else
      redirect_to [@customer, :bookings], notice: "既に予約が取り消されています。"
    end
  end
end

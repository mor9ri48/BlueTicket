class BookingsController < ApplicationController
  def index
    @customer = Customer.find(params[:customer_id])
    @bookings = @customer.bookings
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
  end

  def checkin
    @customer = Customer.find(params[:customer_id])
    @booking = Booking.find(params[:id])
  end

  def new
  end

  # チェックイン
  def update
    @customer = Customer.find(params[:customer_id])
    @booking = Booking.find(params[:id])
    @booking_seat_flight = BookingSeatFlight.where(id: @booking.booking_seat_flight_id)[0]
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

class Admin::BookingsController < ApplicationController
  def index
    @customer = Customer.find(params[:customer_id])
    @bookings = @customer.bookings
  end

  def show
    @customer = Customer.find(params[:customer_id])
    @booking = Booking.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:customer_id])
    @booking = Booking.find(params[:id])
    @booking_seat_flight = BookingSeatFlight.where(id: @booking.booking_seat_flight_id)[0]
    unless @booking_seat_flight.checkin
      @booking_seat_flight.checkin = true
      if @booking_seat_flight.save
        redirect_to [:admin, @customer, @booking], notice: "チェックインが完了しました。"
      else
        redirect_to [:admin, @customer, @booking], notice: "チェックインができませんでした。"
      end
    end
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to [:admin, @customer, :bookings], notice: "予約をキャンセルしました。"
  end
end

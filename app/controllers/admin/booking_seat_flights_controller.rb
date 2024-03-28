class Admin::BookingSeatFlightsController < ApplicationController
  before_action :admin_login_required

  # チェックイン
  def update
    @customer = Customer.find(params[:customer_id])
    @booking = Booking.find(params[:id])
    @seat = Seat.find_by(airmodel_id: params[:airmodel_id], number: params[:seat_number])
    @booking_seat_flight = BookingSeatFlight.find_by(booking_id: @booking.id, seat_id: @seat.id)
    unless @booking_seat_flight.checkin
      @booking_seat_flight.checkin = true
      if @booking_seat_flight.save
        redirect_to [:admin, @customer, @booking], notice: "チェックインが完了しました。"
      else
        redirect_to [:admin, @customer, @booking], notice: "チェックインができませんでした。"
      end
    end
  end
end

class TopController < ApplicationController
  def index
    @canceled_flights = Flight.where("departure_date = ? AND operation = ?", Date.current, false)
  end
end

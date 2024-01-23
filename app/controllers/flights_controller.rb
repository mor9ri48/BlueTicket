class FlightsController < ApplicationController
  def index
    @flights = Flight.order(params[:id])
  end

  def search
  end
end

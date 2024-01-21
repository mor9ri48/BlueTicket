class Airline::Base < ApplicationController
  private def current_airline
    Airline.find_by(id: session[:airline_id]) if session[:airline_id]
  end
  helper_method :current_airline

  class LoginRequired < StandardError; end

  private def airline_login_required
    raise LoginRequired unless current_airline
  end
end
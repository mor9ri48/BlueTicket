class Airline::Base < ApplicationController
  before_action :airline_login_required

  private def airline_login_required
    raise Forbidden unless current_airline
  end
end
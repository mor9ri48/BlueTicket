class TopController < ApplicationController
  def index
    @canceled_flights = Flight.where("departure_date = ? AND operation = ?", Date.current, false)
  end

  def bad_request
    raise ActionController::ParameterMissing, ""
  end

  def forbidden
    raise Forbidden, ""
  end

  def internal_server_error
    raise
  end
end

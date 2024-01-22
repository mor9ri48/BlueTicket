class ApplicationController < ActionController::Base
  private def current_airline
    Airline.find_by(id: session[:airline_id]) if session[:airline_id]
  end
  helper_method :current_airline

  class LoginRequired < StandardError; end

  private def airline_login_required
    raise LoginRequired unless current_airline
  end

  private def current_admin
    Administrator.find_by(id: session[:admin_id]) if session[:admin_id]
  end
  helper_method :current_admin

  private def admin_login_required
    raise LoginRequired unless current_admin
  end
end

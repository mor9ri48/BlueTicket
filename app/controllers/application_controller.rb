class ApplicationController < ActionController::Base
  private def current_customer
    Customer.find_by(id: session[:customer_id]) if session[:customer_id]
  end
  helper_method :current_customer

  class LoginRequired < StandardError; end

  rescue_from LoginRequired, with: :rescue_login_required

  private def rescue_login_required(exception)
    render "customers/login", status: 403, format: [:html]
  end

  private def customer_login_required
    raise LoginRequired unless current_customer
  end

  private def current_admin
    Administrator.find_by(id: session[:admin_id]) if session[:admin_id]
  end
  helper_method :current_admin

  private def admin_login_required
    raise LoginRequired unless current_admin
  end

  private def current_airline
    Airline.find_by(id: session[:airline_id]) if session[:airline_id]
  end
  helper_method :current_airline

  private def airline_login_required
    raise LoginRequired unless current_airline
  end
end

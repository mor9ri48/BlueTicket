class Admin::Base < ApplicationController
  before_action :admin_login_required

  private def admin_login_required
    raise LoginRequired unless current_admin
  end
end
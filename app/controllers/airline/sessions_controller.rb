class Airline::SessionsController < Airline::Base
  def create
    airline = Airline.find_by(login_name: params[:login_name])
    if airline&.authenticate(params[:password])
      session[:airline_id] = airline.id
      redirect_to :airline_root
    else
      flash.alert = "名前とパスワードが一致していません。"
      redirect_to :airline_login
    end
  end

  def destroy
    session.delete(:airline_id)
    redirect_to :airline_root
  end
end

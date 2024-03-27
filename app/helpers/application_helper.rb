module ApplicationHelper
  def page_title
    title = "Blue Ticket"
    title = @page_title + " - " + title if @page_title
    title
  end

  def menu_link_to(text, path, options = {})
    content_tag :li do
      condition = options[:method] || !current_page?(path)

      link_to_if(condition, text, path, options) do
        content_tag(:span, text)
      end
    end
  end

  #予約した分の座席数を減らす
  def the_rest_of_seats(flight, seat_class)
    airmodel = Airmodel.find_by(id: flight.airmodel_id)
    min_seat_id = Seat.where("airmodel_id = ? AND seat_class = ?", airmodel.id, seat_class).first.id
    max_seat_id = Seat.where("airmodel_id = ? AND seat_class = ?", airmodel.id, seat_class).last.id
    booked_seats = BookingSeatFlight.where("flight_id  = ? AND seat_id >= ? AND seat_id <= ?", flight.id, min_seat_id, max_seat_id).count
    if seat_class == "economy"
      rest_number_of_seats = airmodel.economy_nums - booked_seats
    elsif seat_class == "business"
      rest_number_of_seats = airmodel.business_nums - booked_seats
    elsif seat_class == "first"
      rest_number_of_seats = airmodel.first_nums - booked_seats
    end
    rest_number_of_seats
  end
end

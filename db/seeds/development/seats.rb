num = [[240, 90, 12], [222, 60, 6], [90, 18, 0]]

0.upto(2) do |id|
  1.upto(num[id].sum / 6) do |number|
    if number <= num[id][0] / 6
      class_id = 0
    elsif number <= (num[id][0] + num[id][1]) / 6
      class_id = 1
    else
      class_id = 2
    end
    0.upto(5) do |alph|
      Seat.create(
        airmodel_id: id + 1,
        number: ('A'.ord + alph).chr + number.to_s,
        seat_class: ["economy", "business", "first"][class_id],
        price: [0, 2000, 10000][class_id]
      )
    end
  end
end
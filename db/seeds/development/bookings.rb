Booking.create(
  customer_id: 1,
  flight_id: 1000,
  booking_seat_flight_id: 1000,
  total_price: 15000,
  payment_method: "クレジットカード"
)

Booking.create(
  customer_id: 2,
  flight_id: 2789,
  booking_seat_flight_id: 2,
  total_price: 5000,
  payment_method: "PayPay"
)

Booking.create(
  customer_id: 2,
  flight_id: 2790,
  booking_seat_flight_id: 3,
  total_price: 5000,
  payment_method: "コンビニ決済"
)

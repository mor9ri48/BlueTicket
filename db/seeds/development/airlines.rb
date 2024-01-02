names = %w(JAL ANA PEACH)
login_names = %w(jal ana peach)

0.upto(2) do |idx|
  Airline.create(
    name: names[idx],
    login_name: login_names[idx],
    password: "line",
    password_confirmation: "line"
  )
end
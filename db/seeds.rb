table_names = %w(customers airports administrators airlines airmodels seats
  flights bookings booking_seat_flights)
table_names.each do |table_name|
  # 開発用のテーブルの読み込み
  path = Rails.root.join("db/seeds", Rails.env, table_name + ".rb") # 開発用のテーブルのパス
  # パスが存在したら、そのパスが示すテーブルを読み込む(メッセージ文付き)
  if File.exist?(path)
    puts "Creating #{table_name}..."
    require path
  end
end
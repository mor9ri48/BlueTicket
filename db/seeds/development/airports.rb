names = %w(新千歳 羽田 成田 中部 伊丹 関西 福岡 那覇)

names.each do |name|
  Airport.create(name: name)
end
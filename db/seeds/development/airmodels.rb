names = %w(エアバスA350-900 ボーイング787-8227 エンブラエル190)
num = [[240,90,12],[222,60,6],[90,18,0]]

0.upto(2) do |i|
  Airmodel.create(
    name: names[i],
    economy_nums: num[i][0],
    business_nums: num[i][1],
    first_nums: num[i][2]
  )
end
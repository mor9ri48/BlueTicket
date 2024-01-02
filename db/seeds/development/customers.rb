names = %w(佐竹弘靖 山下清美 砂原由和 石鎚英也 松永賢次
    飯田周作 小林隆 上平崇仁 飯塚佳代 藤原正仁
    佐藤慶一 土屋翔一 太田隆博 小杉尚子 宮津和弘
    栗芝正臣 神白哲史 望月俊男 小田切健太 河野敏鑑
    沼晃介 石井健太郎 安藤映 杉田このみ 榮谷昭宏)
   
alph_names = ["SATAKE HIROYASU", "YAMASHITA KIYOMI", "SUNAHARA YOSHIKAZU",
                "ISHIZUCHI HIDEYA", "MATSUNAGA KENJI", "IIDA SHUSAKU", "KOBAYASHI TAKASHI",
                "KAMIHIRA TAKAHITO", "IIZUKA KAYO", "FUJIHARA MASAHITO", "SATO KEIICHI",
                "TSUCHIYA SHOICHI", "OTA TAKAHIRO", "KOSUGI NAOKO", "MIYATSU KAZUHIRO",
                "KURISHIBA MASAOMI", "KAJIRO TETSUSHI", "MOCHIZUKI TOSHIO", "ODAGIRI KENTA",
                "KONO TOSHIAKI", "NUMA KOSUKE", "ISHII KENTARO", "ANDO EI",
                "SUGITA KONOMI", "SAKAEDANI AKIHIRO"]
   
login_names = %w(satake yamashita sunahara ishizuchi matsunaga
  iida kobayashi kamihira iizuka fujihara
  sato tsuchiya ota kosugi miyatsu
  kurishiba kajiro mochizuki odagiri kono
  numa ishii ando sugita sakaedani)
   
sexes = %w(1 2 1 1 1 1 1 1 2 1 1 1 1 2 1 1 1 1 1 1 1 1 1 2 1)
   
0.upto(24) do |i|
  Customer.create(
    name: names[i],
    alph_name: alph_names[i],
    login_name: login_names[i],
    birthday: "1981-12-01",
    sex: sexes[i].to_i,
    password: "blue",
    password_confirmation: "blue",    
    email: "#{login_names[i]}@example.com"
  )
end   
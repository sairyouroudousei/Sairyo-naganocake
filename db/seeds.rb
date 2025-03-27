# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email: 'test@test.com',
   password: 'testtest'
)

#ジャンルの作成
genres = [
  { name: "焼き菓子"},
  { name: "ケーキ" },
  { name: "プリン" },
  { name: "キャンディ" }
]
Genre.create!(genres)

#初期商品登録

item = Item.create(
  name: "王道マドレーヌ",
  introduction: "これぞ王道！これぞ王道！これぞ王道！これぞ王道！これぞ王道！これぞ王道！",
  price: 680,
  genre_id: 1,
  #image: File.open(Rails.root.join('/app/assets/images/yakigashi_madeleine.jpg'))
)
item.image.attach(io: File.open(Rails.root.join('app/assets/images/yakigashi_madeleine.jpg')),filename: 'yakigashi_madeleine.jpg')

item = Item.create(
  name: "ハートのマカロン",
  introduction: "味良し！見た目良し！",
  price: 1080,
  genre_id: 1,
)
item.image.attach(io: File.open(Rails.root.join('app/assets/images/焼き菓子_ハートのマカロン.jpg')),filename: '焼き菓子_ハートのマカロン.jpg')


item = Item.create(
   name: "ナッツとチョコのカップケーキ",
   introduction: "甘さ控えめ",
   price: 680,
   genre_id: 2,
  )
item.image.attach(io: File.open(Rails.root.join('app/assets/images/cake_ナッツとチョコのカップケーキ.jpg')),filename: 'cake_ナッツとチョコのカップケーキ.jpg')

item = Item.create(
   name: "ホールケーキ",
   introduction: "８号サイズ",
   price:2580 ,
   genre_id:2,
  )
item.image.attach(io: File.open(Rails.root.join('app/assets/images/cake_ホールケーキ.jpg')),filename: 'cake_ホールケーキ.jpg')

item = Item.create(
   name: "ナガノグミベア",
   introduction: "インスタ神バズり！",
   price: 680,
   genre_id:4,
  )
item.image.attach(io: File.open(Rails.root.join('app/assets/images/candy_ナガノグミベア.jpg')),filename: 'candy_ナガノグミベア.jpg')

item = Item.create(
   name: "いちごのパンナコッタ",
   introduction: "季節限定",
   price: 680,
   genre_id:3,
  )
item.image.attach(io: File.open(Rails.root.join('app/assets/images/pudding_いちごのパンナコッタ.jpg')),filename: 'pudding_いちごのパンナコッタ.jpg')

item = Item.create(
   name: "ミルクプリン",
   introduction: "どこか懐かしい味",
   price: 500,
   genre_id:3,
  )
item.image.attach(io: File.open(Rails.root.join('app/assets/images/pudding_ミルクプリン.jpg')),filename: 'pudding_ミルクプリン.jpg')

item = Item.create(
   name: "瓶詰めキャンディ",
   introduction: "生成AI印の特製キャンディ",
   price:500,
   genre_id:4,
  )
item.image.attach(io: File.open(Rails.root.join('app/assets/images/飴.png')),filename: '飴.png')
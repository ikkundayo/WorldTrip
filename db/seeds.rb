require "csv"

CSV.foreach('db/csv/country_list.csv', headers: true) do |row|
  Country.create(
    code: row['code'],
    name_en: row['name_en'],
    name_jp: row['name_jp'],
    area: row['area']
  )
end

Admin.create!(
  email: "aaa@a",
  password: "111111"
  )

array = %w(アドバイス 現地の声 体験談 質問 新型コロナウイルスについて その他)
array.each{ |tag|
  tag_list = ActsAsTaggableOn::Tag.new
  tag_list.name = tag
  tag_list.save
}

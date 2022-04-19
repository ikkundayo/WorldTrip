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

User.create!(
  [
    {
      email: 'aaa@a',
      password: '111111',
      user_name: 'ルフィ',
      country_code: 'アメリカ',
      gender: '男',
      birth_date: '2000-05-06',
      introduction: '俺は海賊王になる',
      is_deleted: 'true'
    },
    {
      email: 'aaa@aa',
      password: '111111',
      user_name: 'ゾロ',
      country_code: '日本',
      gender: '男',
      birth_date: '1996-10-06',
      introduction: '世界一の大剣豪',
      is_deleted: 'true'
    },
    {
      email: 'a@a',
      password: '111111',
      user_name: 'ナミ',
      country_code: 'ルーマニア',
      gender: '女',
      birth_date: '2000-01-01',
      introduction: '泥棒猫',
      is_deleted: 'true'
    }
  ]
)
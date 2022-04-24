class Public::HomesController < ApplicationController
  def top
    @reviews = Review.group(:country_code).where(season: true, created_at: Time.current.all_month).order('count(country_code) desc').limit(3)

  unless Memory.first.blank?
    @memories = Memory.where( 'id >= ?', rand(Memory.first.id..Memory.last.id) ).limit(3)
  else
    @memories = {}
  end


    @hints_voices = Hint.tagged_with('現地の声')
    @hints_coronas = Hint.tagged_with('新型コロナウイルスについて')
    #↑の書き方はデータが増えれば増えるほど時間がかかる？



  end

  def about
  end
end

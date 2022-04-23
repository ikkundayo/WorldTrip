class Public::HomesController < ApplicationController
  def top
    @season = Review.where(season: true)
    @reviews = @season.group(:country_code).where(created_at: Time.current.all_month).order('count(country_code) desc').limit(3)

    @memories = Memory.where( 'id >= ?', rand(Memory.first.id..Memory.last.id) ).limit(3)
  end

  def about
  end
end

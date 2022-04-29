class Public::ReviewLikesController < ApplicationController

  def create
    @review = Review.find_by(country_code: params[:review_id])
    @country = Country.find_by(name_jp: params[:review_id])
    @like = Like.create(user_id: current_user.id, review_id: @country.name_jp)
    @like = Like.where(user_id: current_user.id)

  end

  def destroy
    @review = Review.find_by(country_code: params[:review_id])
    @country = Country.find_by(name_jp: params[:review_id])
    @like = Like.find_by(user_id: current_user.id, review_id: @country.name_jp)
    @like.destroy
    @like = Like.where(user_id: current_user.id)
  end

end

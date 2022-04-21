class Public::ReviewLikesController < ApplicationController

  def create
    @country = Country.find_by(name_jp: params[:review_id])
    @like = Like.create(user_id: current_user.id, review_id: @country.name_jp)
  end

  def destroy
    @country = Country.find_by(name_jp: params[:review_id])
    @like = Like.find_by(user_id: current_user.id, review_id: @country.name_jp)
    @like.destroy
  end
end

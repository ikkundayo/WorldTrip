class Public::HintLikesController < ApplicationController

  before_action :hint_find

  def create
    @like = Like.create(user_id: current_user.id, hint_id: params[:hint_id])
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, hint_id: params[:hint_id])
    like.destroy
  end

  private

  def hint_find
    @hint = Hint.find(params[:hint_id])
  end
end

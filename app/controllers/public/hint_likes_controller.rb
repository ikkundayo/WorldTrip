class Public::HintLikesController < ApplicationController

  def create
    @hint = Hint.find(params[:hint_id])
    @like = Like.create(user_id: current_user.id, hint_id: params[:hint_id])
    @hint.create_notification_like!(current_user)
  end

  def destroy
    @hint = Hint.find(params[:hint_id])
    like = Like.find_by(user_id: current_user.id, hint_id: params[:hint_id])
    like.destroy
  end

end

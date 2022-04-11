class Public::LikesController < ApplicationController

  def create
    @like = Like.create(user_id: current_user.id, memory_id: params[:memory_id])
    redirect_to memories_path
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, memory_id: params[:memory_id])
    like.destroy
    redirect_to memories_path
  end


  private

end

class Public::MemoryLikesController < ApplicationController

  def create
    @memory = Memory.find(params[:memory_id])
    @like = Like.create(user_id: current_user.id, memory_id: params[:memory_id])
    @memory.create_notification_like!(current_user)
  end

  def destroy
    @memory = Memory.find(params[:memory_id])
    like = Like.find_by(user_id: current_user.id, memory_id: params[:memory_id])
    like.destroy
  end

end

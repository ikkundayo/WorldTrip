class Public::MemoryCommentsController < ApplicationController

  before_action :memory_find

  def create
    if user_signed_in?
      comment = current_user.comments.new(memory_comment_params)
      comment.memory_id = @memory.id
      if comment.save
        redirect_to memory_path(@memory)
      else
        flash[:notice] = "空白では投稿できません"
        redirect_to memory_path(@memory)
      end
    else
      flash[:notice] = "お手数おかけしますがご投稿いただく際はログインまたは新規登録をお願いします。"
      redirect_to new_user_registration_path
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to memory_path(@memory)
  end

  private

  def memory_find
    @memory = Memory.find(params[:memory_id])
  end

  def memory_comment_params
    params.require(:comment).permit(:comment)
  end
end

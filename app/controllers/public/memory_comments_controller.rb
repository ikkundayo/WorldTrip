class Public::MemoryCommentsController < ApplicationController

  def create
    if user_signed_in?
      @memory = Memory.find(params[:memory_id])
      comment = current_user.comments.new(memory_comment_params)
      comment.memory_id = @memory.id
      if comment.save
        @memory.create_notification_comment!(current_user, comment.id)
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
    @memory = Memory.find(params[:memory_id])
    Comment.find(params[:id]).destroy
  end


  private

  def memory_comment_params
    params.require(:comment).permit(:comment)
  end
end

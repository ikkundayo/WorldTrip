class Public::HintCommentsController < ApplicationController
before_action :hint_find

  def create
    if user_signed_in?
      comment = current_user.comments.new(hint_comment_params)
      comment.hint_id = @hint.id
      if comment.save
      else
        flash[:notice] = "空白では投稿できません"
        redirect_to hint_path(@hint)
      end
    else
      flash[:notice] = "お手数おかけしますがご投稿いただく際はログインまたは新規登録をお願いします。"
      redirect_to new_user_registration_path
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
  end

  private

  def hint_find
    @hint = Hint.find(params[:hint_id])
  end

  def hint_comment_params
    params.require(:comment).permit(:comment)
  end
end

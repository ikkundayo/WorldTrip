class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.order(review_average: :desc).page(params[:page]).per(10)
    @memories = @user.memories.page(params[:page]).per(10)
    @hints = @user.hints.page(params[:page]).per(10)
    if params[:tag_name]
      @hints = Hint.tagged_with("#{params[:tag_name]}")
    end
    @user_logo = Country.find_by(name_jp: @user.country_code)
    @user_age = (Date.today.strftime("%Y%m%d").to_i - @user.birth_date.strftime("%Y%m%d").to_i)/10000
    @ranking = @user.reviews.order(review_average: :desc).limit(3)
    @review = @user.reviews
    @country_progress = (@review.count.to_f / 260.to_f) * 100.to_f
    @map = @user.reviews

    @likes = Like.where(user_id: params[:id]).page(params[:page]).per(10)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if params[:quit_button].present?
      @user.update(is_deleted: false)
      reset_session
      redirect_to root_path
    else
      if @user.update(user_params)
        redirect_to user_path(@user), notice: "You have updated user successfully."
      else
        render "edit"
      end
    end
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  def followed
    @user = User.find(params[:id])
    @users = @user.followeds
  end


  private

  def user_params
    params.require(:user).permit(:user_name, :introduction, :is_deleted, :user_image)
  end
end

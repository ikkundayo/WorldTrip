class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_age = (Date.today.strftime("%Y%m%d").to_i - @user.birth_date.strftime("%Y%m%d").to_i)/10000
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :introduction, :is_deleted, :user_image)
  end
end

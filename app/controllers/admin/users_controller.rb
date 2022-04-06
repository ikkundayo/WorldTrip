class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user.is_deleted == true
      @user.update(is_deleted: false)
    else
      @user.update(is_deleted: true)
    end
    redirect_to admin_users_path, notice: "会員の情報が更新されました"
  end

end

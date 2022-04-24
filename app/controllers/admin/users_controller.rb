class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10)
    @q = User.ransack(params[:q])
    @search = @q.result(distinct: true).page(params[:page]).per(10)
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

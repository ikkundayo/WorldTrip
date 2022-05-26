class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    follower = current_user.relationships.build(followed_id: params[:user_id])
    follower.save
    
    @user = User.find(params[:user_id])
    @user.create_notification_follow!(current_user)
    redirect_to request.referrer || root_path
  end

  def destroy
    follower = current_user.relationships.find_by(followed_id: params[:user_id])
    follower.destroy
    redirect_to request.referrer || root_path
  end
end

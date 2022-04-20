class Public::HintsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.order(id: "ASC").pluck(:name)
    @hints = Hint.page(params[:page]).per(10)
    if params[:tag_name]
      @hints = Hint.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10)
    end
    @q = Hint.ransack(params[:q])
    @search = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @hint = Hint.find(params[:id])
    @country_logo = Country.find_by(name_jp: @hint.country_code)
    @country_user_logo = Country.find_by(name_jp: @hint.user.country_code)
    @hint_comment = Comment.new
  end

  def new
    if user_signed_in?
      @hint = Hint.new
      @tags = ActsAsTaggableOn::Tag.all
    else
      flash[:notice] = "お手数おかけしますがご投稿いただく際はログインまたは新規登録をお願いします。"
      redirect_to new_user_registration_path
    end
  end

  def create
    @hint = Hint.new(hint_params)
    @hint.user_id = current_user.id
    if @hint.save
      redirect_to hints_path
    else
      render 'new'
    end
  end

  def destroy
    @hint = Hint.find(params[:id])
    @hint.destroy
    redirect_to hints_path
  end

  private

  def hint_params
    params.require(:hint).permit(:tag_list, :hint_image, :user_id, :country_code, :hint_contents)
  end
end

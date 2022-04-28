class Public::MemoriesController < ApplicationController
  def index
    @memory = Memory.order(created_at: :desc).page(params[:page]).per(10)
    if user_signed_in?
      @following = Memory.where(user_id: [current_user.id,*current_user.follower_ids]).order(created_at: :desc).page(params[:page]).per(10)

      @review = Review.where(user_id: current_user.id).pluck(:country_code)
      @traveled = Memory.where(country_code: @review).page(params[:page]).per(10)

      @country_like = Like.where(user_id: current_user.id).pluck(:review_id)
      @want = Memory.where(country_code: @country_like).order(created_at: :desc).page(params[:page]).per(10)

    end
    @q = Memory.ransack(params[:q])
    @search = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @memory = Memory.find(params[:id])
    @country_logo = Country.find_by(name_jp: @memory.country_code)
    @country_user_logo = Country.find_by(name_jp: @memory.user.country_code)
    @memory_comment = Comment.new
  end

  def new
    if user_signed_in?
      @memory = Memory.new
      @review = current_user.reviews
    else
      flash[:notice] = "お手数おかけしますがご投稿いただく際はログインまたは新規登録をお願いします。"
      redirect_to new_user_registration_path
    end
  end

  def create
    @memory = Memory.new(memory_params)
    @memory.user_id = current_user.id
    if @memory.save
      redirect_to memories_path('type': 'link'), notice: "You have created memory successfully."
    else
      @review = current_user.reviews
      render 'new'
    end
  end

  def destroy
    @memory = Memory.find(params[:id])
    @memory.destroy
    redirect_to memories_path('type': 'link'), notice: "The memory was deleted."
  end

  def search
    @country = Country.find(params[:memory_id])
    @memory = Memory.where(country_code: @country.name_jp).order(created_at: :desc).page(params[:page]).per(10)
    @memorys = Memory.find_by(country_code: @country.name_jp)
  end


  private

  def memory_params
    params.require(:memory).permit(:memory_image, :user_id, :country_code, :memory_contents)
  end

end

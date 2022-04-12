class Public::ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def new
    if user_signed_in?
      @review = Review.new
      @country = Country.all
    else
      flash[:notice] = "お手数おかけしますがご投稿いただく際はログインまたは新規登録をお願いします。"
      redirect_to new_user_registration_path
    end
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @total = @review.review_averages
    @review.review_average = @total
    if @review.save
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to user_path(current_user)
  end

  def review_params
    params.require(:review).permit(
      :user_id,
      :country_code,
      :amusement_rate,
      :amusement_voice,
      :gourmet_rate,
      :gourmet_voice,
      :security_rate,
      :security_voice,
      :recommend_rate,
      :recommend_voice,
      :original_category,
      :original_rate,
      :original_voice,
      :season
      )
  end
end

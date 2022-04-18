class Public::ReviewsController < ApplicationController
  def index
    @country = Country.order(:name_jp).page(params[:page]).per(10)
    @review = Review.all.limit(3)

    # @test = Review.group(:country_code).average(:review_average)
    
    # @test2 = Review.find(Review.group(:country_id).order('avg(review_average)').pluck(:country_id))
    # Review.group(:country_code).order('count_country_code DESC').count(:country_code)
    #上記のようにcountryからじゃなくてreviewからランキングを出すといい?

  end

  def show
    @country = Country.find(params[:id])
    @review = @country.reviews

  end

  def new
    if user_signed_in?
      @review = Review.new
    else
      flash[:notice] = "お手数おかけしますがご投稿いただく際はログインまたは新規登録をお願いします。"
      redirect_to new_user_registration_path
    end
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.country_code = Country.find(params[:review][:country_id]).name_jp
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
      :country_id,
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

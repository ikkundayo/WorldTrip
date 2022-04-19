class Public::ReviewsController < ApplicationController
  def index
    @average = Review.select('AVG(review_average) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(10)
    @amusement = Review.select('AVG(amusement_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(10)
    @gourmet = Review.select('AVG(gourmet_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(10)
    @security = Review.select('AVG(security_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(10)
    @recommend = Review.select('AVG(recommend_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(10)
    @original = Review.select('AVG(original_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(10)
    
  end


  def show
    @country = Country.find(params[:id])

    @reviews = Review.where(country_id: params[:id])
    # if @reviews = blank?
    #   @reviews.review_average = 0
    # end
    # .presence || "0"


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

class Public::ReviewsController < ApplicationController

  def index
    @q = Review.ransack(params[:q])

    @average = Review.select('AVG(review_average) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(20)
    @amusement = Review.select('AVG(amusement_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(20)
    @gourmet = Review.select('AVG(gourmet_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(20)
    @security = Review.select('AVG(security_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(20)
    @recommend = Review.select('AVG(recommend_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(20)
    @original = Review.select('AVG(original_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(20)

    @country = Country.select(:area).distinct
    @review = @q.result(distinct: true)
    @search = @review.select('AVG(review_average) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(20)

    if user_signed_in?
      @experience = Review.where(user_id: current_user.id)
      @like = Like.where(user_id: current_user.id)
    end

    # if @q.blank?
    #   @review = Review.all
    # else
    #   @review = @q.result(distinct: true)
    # end
  end


  def show
    if params[:id] =~ /\A[0-9]+\z/
      @country = Country.find(params[:id])
      @reviews = Review.where(country_id: params[:id]).page(params[:page]).per(10)
    else
      @country = Country.find_by(code: params[:id])
      @reviews = Review.where(code: params[:id]).page(params[:page]).per(10)
    end

    if user_signed_in?
      @experience = Review.where(user_id: current_user.id)
      @like = Like.where(user_id: current_user.id)
    end

    @memory_count = Memory.where(country_code: @country.name_jp)
    @hint_count = Hint.where(country_code: @country.name_jp)
    @travel_count = Review.where(country_code: @country.name_jp)
    @wish_count = Like.where(review_id: @country.name_jp)



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
    @review.area = Country.find(params[:review][:country_id]).area
    @review.code = Country.find(params[:review][:country_id]).code
    @total = @review.review_averages
    @review.review_average = @total
    @like = Like.find_by(user_id: current_user.id, review_id: @review.country_code)
    if @like.present?
      if @review.country_code == @like.review_id
        @like.destroy
      end
    end
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

  private


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

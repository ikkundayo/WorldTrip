class Public::ReviewsController < ApplicationController

  def index
    @q = Review.ransack(params[:q])

    @average = Review.select('AVG(review_average) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(50)
    @amusement = Review.select('AVG(amusement_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(50)
    @gourmet = Review.select('AVG(gourmet_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(50)
    @security = Review.select('AVG(security_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(50)
    @recommend = Review.select('AVG(recommend_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(50)
    @original = Review.select('AVG(original_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(50)

    @country = Country.select(:area).distinct
    @review = @q.result(distinct: true)
    @search = @review.select('AVG(review_average) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(50)

    if user_signed_in?
      @experience = Review.where(user_id: current_user.id)
      @like = Like.where(user_id: current_user.id)
    end

    if params[:type] == 'month-travel'
      @travel = Review.group(:country_code).where(season: true, created_at: Time.current.all_month).order('count(country_code) desc').page(params[:page]).per(50)
    elsif params[:type] == 'week-travel'
      @travel = Review.group(:country_code).where(season: true, created_at: Time.current.all_week).order('count(country_code) desc').page(params[:page]).per(50)
    else
      @travel = Review.group(:country_code).order('count(country_code) desc').page(params[:page]).per(50)
    end
  end


  def show
    if params[:id] =~ /\A[0-9]+\z/
      @country = Country.find(params[:id])
      @reviews = Review.where(country_id: params[:id])
    else
      @country = Country.find_by(code: params[:id])
      @reviews = Review.where(code: params[:id])
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
    @like = Like.find_by(user_id: current_user.id, review_id: @review.country_code)
    if @like.present?
      if @review.country_code == @like.review_id
        @like.destroy
      end
    end
    if @review.save
      redirect_to user_path(current_user), notice: "You have created memory successfully."
    else
      render 'new'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to user_path(current_user)
  end

  def search
    @link = Review.find_by(area: params[:review_id])
    @area = Review.where(area: params[:review_id])
    @average = @area.select('AVG(review_average) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(20)
    @amusement = @area.select('AVG(amusement_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(20)
    @gourmet = @area.select('AVG(gourmet_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(20)
    @security = @area.select('AVG(security_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(20)
    @recommend = @area.select('AVG(recommend_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(20)
    @original = @area.select('AVG(original_rate) as avg ,country_code, country_id').group(:country_code).order(avg: :DESC).page(params[:page]).per(20)

    if params[:type] == 'month-travel'
      @travel = @area.group(:country_code).where(season: true, created_at: Time.current.all_month).order('count(country_code) desc').page(params[:page]).per(20)

    elsif params[:type] == 'week-travel'
      @travel = @area.group(:country_code).where(season: true, created_at: Time.current.all_week).order('count(country_code) desc').page(params[:page]).per(20)
    else
      @travel = @area.group(:country_code).order('count(country_code) desc').page(params[:page]).per(20)
    end

    if user_signed_in?
      @experience = Review.where(user_id: current_user.id)
      @like = Like.where(user_id: current_user.id)
    end
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

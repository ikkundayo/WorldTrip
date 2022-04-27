class Public::HintsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.order(id: "ASC").pluck(:name)
    @hints = Hint.order(created_at: :desc).page(params[:page]).per(10)
    # if user_signed_in?
    #   @following = Hint.where(user_id: [current_user.id,*current_user.follower_ids]).page(params[:page]).per(10)
    # end

    if params[:tag_name]
      @hints = Hint.tagged_with("#{params[:tag_name]}").order(created_at: :desc).page(params[:page]).per(10)
      # @following = Hint.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10)
    end
    @q = Hint.ransack(params[:q])
    @search = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
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

  def search
    @q = Hint.ransack(params[:q])
    @tags = ActsAsTaggableOn::Tag.order(id: "ASC").pluck(:name)

    if params[:hint_id] == "hoge"
      @search = @q.result(distinct: true).pluck(:country_code)
      @hints = Hint.where(country_code: @search).order(created_at: :desc).page(params[:page]).per(10)

    elsif params[:type] == "search-tag"
      @id = params[:hint_id]

      @search = Hint.where('country_code Like(?)', "%#{params[:hint_id]}%").pluck(:country_code)
      @hints = Hint.where(country_code: @search).order(created_at: :desc).page(params[:page]).per(10)
      if params[:tag_name] == "アドバイス" || params[:tag_name] == "体験談" || params[:tag_name] == "現地の声" || params[:tag_name] == "質問" || params[:tag_name] == "新型コロナウイルスについて" || params[:tag_name] == "その他"
        @hints = @hints.tagged_with("#{params[:tag_name]}").order(created_at: :desc).page(params[:page]).per(10)
      end
    else
      @country = Country.find(params[:hint_id])
      @hints = Hint.where(country_code: @country.name_jp).order(created_at: :desc).page(params[:page]).per(10)
      @country_name = Hint.find_by(country_code: @country.name_jp)

      if params[:tag_name]
        @hints = @hints.tagged_with("#{params[:tag_name]}").order(created_at: :desc).page(params[:page]).per(10)
      end
    end

    # else
    #   @search = @q.result(distinct: true).pluck(:country_code)
    #   @country = Country.where(name_jp: @search)
    #   @hints = Hint.where(country_code: @search).page(params[:page]).per(10)
    # end


  end

  private

  def hint_params
    params.require(:hint).permit(:tag_list, :hint_image, :user_id, :country_code, :hint_contents)
  end
end

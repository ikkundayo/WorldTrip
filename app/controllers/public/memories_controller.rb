class Public::MemoriesController < ApplicationController
  def index
    @memory = Memory.all
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
      redirect_to memories_path
    else
      render 'new'
    end
  end

  def destroy
    @memory = Memory.find(params[:id])
    @memory.destroy
    redirect_to memories_path
  end


  private

  def memory_params
    params.require(:memory).permit(:memory_image, :user_id, :country_code, :memory_contents)
  end

end

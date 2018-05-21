class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    redirect_to "/tasks/#"
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "登録が完了しました。"
      redirect_to "/tasks/#"
    else
      flash.now[:danger] = "登録に失敗しました。"
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end


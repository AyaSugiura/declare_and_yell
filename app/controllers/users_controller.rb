class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:index, :edit, :update, :show]
  
  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_edit_params)
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ情報は更新されませんでした'
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def user_edit_params
    params.require(:user).permit(:name, :message, :image)
  end
  
  
end

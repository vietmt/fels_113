class UsersController < ApplicationController

  before_action :authorize_user, except: [:new, :create]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :signed, only: [:new, :create]

  def index
    @users = User.paginate page: params[:page], per_page: Settings.number_user_in_list
  end

  def show
    @activities = @user.load_own_activities.paginate page: params[:page],
      per_page: Settings.number_activity_in_list
    @words = Word.send "learned", @user.id
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in @user
      flash[:success] = t "welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user && @user.update_attributes(user_params)
      flash[:success] = t "user.profileupdated"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def find_user
    @user = User.find_by id: params[:id]
  end

  def signed
    if signed_in?
      flash[:notice] = t "signin.signed"
      redirect_to root_url
    end
  end
end

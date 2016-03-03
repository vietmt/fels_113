class UsersController < ApplicationController

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

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def correct_user
    redirect_to root_url unless current_user == @user
  end

  def find_user
    @user = User.find_by id: params[:id]
  end

  def signed
    if user_signed_in?
      flash[:notice] = t "signin.signed"
      redirect_to root_url
    end
  end
end

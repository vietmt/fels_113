class Admin::UsersController < Admin::ActionBaseController

  def index
    @users = User.paginate page: params[:page], per_page: Settings.number_user_in_list
  end

  def destroy
    user = User.find_by id: params[:id]
    user.destroy unless user == current_user
    redirect_to admin_users_path
  end
end

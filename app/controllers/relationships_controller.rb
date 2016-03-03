class RelationshipsController < ApplicationController

  def index
    type = params[:type]
    @user = User.find params[:user_id]
    @users = @user.send(type).paginate page: params[:page]
  end

  def create
    @user = User.find params[:relationship][:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end

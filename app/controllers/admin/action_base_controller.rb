class Admin::ActionBaseController < ApplicationController

  before_action :authorize_user
  before_action :require_admin
  private
  def require_admin
    unless  current_user.admin?
      flash[:danger] = t "admin.requiresignin"
      redirect_to root
    end
  end
end

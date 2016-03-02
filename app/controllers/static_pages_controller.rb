class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @activities = current_user.load_activities.paginate page: params[:page],
        per_page: Settings.number_activity_in_list
      @words = Word.send "learned", current_user.id
    end
  end

  def help
  end

  def about
  end
end

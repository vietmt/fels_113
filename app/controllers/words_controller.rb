class WordsController < ApplicationController
  def index
    @categories = Category.all
    @user = params[:user_id].nil? ? current_user : User.find(params[:user_id])
    if params[:category_id] && params[:category_id].empty?
      @words = Word.send (params[:option].nil? ? "all_word":params[:option]), @user.id
    elsif category = @categories.detect{|category| category.id == params[:category_id].to_i}
      @words = category.words.send (params[:option].nil? ? "all_word":params[:option]), @user.id
    else
      @words = []
    end
  end
end

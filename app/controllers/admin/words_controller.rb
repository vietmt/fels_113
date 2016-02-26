class Admin::WordsController < ApplicationController
  before_action :load_category, only: [:create, :update, :edit]
  before_action :load_word, except: :create

  def create
    @word = @category.words.new word_params
    if @word.save
      flash[:success] = t "word.created"
      redirect_to admin_category_path @word.category
    else
      @words = @category.words.paginate page: params[:page]
      Settings.number_answers.times{@word.answers.build} if @word.answers.empty?
      render "admin/categories/show"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @word && @word.update_attributes(word_params)
      flash[:success] = t "word.updated"
      redirect_to admin_category_path @word.category
    else
      render :edit
    end
  end

  def destroy
    if @word
      @word.destroy
      flash[:success] = t "word.deleted"
      redirect_to admin_category_path @word.category
    else
      redirect_to admin_categories_path
    end
  end

  private
  def word_params
    params.require(:word).permit :id ,:content, :image, :sound,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_category
    @category = Category.find_by id: params[:category_id]
    redirect_to admin_categories_path unless @category
  end

  def load_word
    @word = Word.find_by id: params[:id]
    redirect_to admin_categories_path unless @word
  end
end

class LessonsController < ApplicationController
  before_action :authorize_user
  before_action :load_category, only: [:create]
  before_action :load_lesson, only: [:show, :update]

  def show
  end

  def create
    @lesson = current_user.lessons.new category_id: @category.id
    if @lesson.save
      flash[:success] = t "lesson.newcomplete"
      redirect_to @lesson
    else
      flash[:danger] = t "lesson.newfail"
      redirect_to categories_path
    end
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t "lesson.updatecomplete"
    else
      flash[:danger] = t "lesson.updatefail"
    end
    redirect_to @lesson
  end

  private
  def load_category
    @category = Category.find_by id: params[:lesson][:category_id]
    redirect_to categories_path unless @category
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    redirect_to categories_path unless @lesson
  end

  def lesson_params
    params.require(:lesson).permit :learned, lesson_words_attributes: [:id, :answer_id]
  end
end

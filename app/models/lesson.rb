class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words

  accepts_nested_attributes_for :lesson_words

  before_create :create_words

  private
  def create_words
    self.words = self.category.words.order("RANDOM()").limit Settings.number_word_in_lessons
  end
end

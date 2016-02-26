class Lesson < ActiveRecord::Base
  before_create :create_words
  before_update :create_activity_when_update
  after_create :create_activity_when_create

  belongs_to :category
  belongs_to :user

  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words

  accepts_nested_attributes_for :lesson_words

  before_create :create_words

  private
  def create_words
    @words = self.category.words.send ("no_learn"), self.user_id
    self.words = @words.order("RANDOM()").limit Settings.number_word_in_lessons
  end

  def create_activity_when_create
    user.activities.create state: :learning, target_id: id
  end

  def create_activity_when_update
    user.activities.create state: :learned, target_id: id
  end
end

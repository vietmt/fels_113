class Answer < ActiveRecord::Base

  belongs_to :word

  has_many :lesson_words, dependent: :destroy

  validates :content, presence: true, length: {maximum: 50}

  scope :correct,->{where is_correct: true}
end

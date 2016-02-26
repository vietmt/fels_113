class Answer < ActiveRecord::Base

  belongs_to :word

  validates :content, presence: true, length: {maximum: 50}

  scope :correct,->{where is_correct: true}
end

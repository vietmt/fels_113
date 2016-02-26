class Word < ActiveRecord::Base

  belongs_to :category

  has_many :answers, dependent: :destroy

  scope :all_word, ->user_id{}
  scope :learned, ->user_id{where "id in (select word_id from lesson_words where
    lesson_id in (select id from lessons where user_id = #{user_id}))"}
  scope :no_learn, ->user_id{where "id not in (select word_id from lesson_words where
    lesson_id in (select id from lessons where user_id = #{user_id}))"}

  mount_uploader :image, AvatarUploader
  mount_uploader :sound, SoundUploader

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc {|answer| answer[:content].blank?}

  validates :content, presence: true, length: {maximum: 50}
  validate :must_has_one_correct_answer

  private
  def must_has_one_correct_answer
    errors.add :base, I18n.t("word.musthasonlyonecorrect") unless
      self.answers.select{|ans| ans.is_correct}.size == 1
  end
end

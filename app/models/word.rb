class Word < ActiveRecord::Base

  belongs_to :category

  has_many :answers, dependent: :destroy

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

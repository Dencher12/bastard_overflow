class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable
  has_many :users_rate_answers
  has_many :rate_users, through: :users_rate_answers, source: :user

  validates :body, presence: true

  accepts_nested_attributes_for :attachments

  scope :sorted, -> { order(mark: :desc) }
end

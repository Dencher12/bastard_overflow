class Question < ApplicationRecord
  has_many :answers
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachable
  belongs_to :user

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments
end

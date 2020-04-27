class Question < ApplicationRecord
  has_many :answers
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachable
  belongs_to :user

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments

  def set_user(user)
    self.user = user
    self.save
    self
  end 

  def mark_answer(marked_answer)
    self.answers.each do |answer|
      answer.mark = false
      answer.mark = true if answer == marked_answer
      answer.save
    end
  end  
end

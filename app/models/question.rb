class Question < ApplicationRecord
  has_many :answers
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachable
  belongs_to :user

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments

  def self.todays
    Question.all.select {|q| "#{q.created_at.day}-#{q.created_at.month}-#{q.created_at.year}" == "#{Time.now.day}-#{Time.now.month}-#{Time.now.year}" }
  end  


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

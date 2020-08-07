class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachable
  has_many :users_rate_answers
  has_many :rate_users, through: :users_rate_answers, source: :user

  validates :body, presence: true

  accepts_nested_attributes_for :attachments

  scope :sorted, -> { order(mark: :desc) }

  after_commit :send_out

  def send_out
    question.subscriptions.each do |s|
      s.user.send_new_answer_notice(question)
    end  
  end  

  def set_user(user)
    self.user = user
    self.save
    self
  end

  def add_to_rate_users(user)
    self.rate_users << user
    self.save
  end  
end

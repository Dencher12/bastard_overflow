class User < ApplicationRecord
  has_many :answers
  has_many :questions
  has_many :users_rate_answers
  has_many :rate_answers, through: :users_rate_answers, source: :answer

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true
end

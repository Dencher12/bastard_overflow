class User < ApplicationRecord
  has_many :answers
  has_many :questions
  has_many :users_rate_answers
  has_many :rate_answers, through: :users_rate_answers, source: :answer
  has_many :authhorizations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]

  validates :email, presence: true

  def self.send_daily_digest
    UserMailer.daily_digest.deliver_now
  end  

  def self.find_for_oauth(auth)
    authhorization = Authhorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authhorization.user if authhorization

    email = auth.info[:email]
    user = User.where(email: email).first
    if user
      user.authhorizations.create(provider: auth.provider, uid: auth.uid)
    else
      password = Devise.friedly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
    end
    user  
  end  
end

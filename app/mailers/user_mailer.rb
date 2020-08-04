class UserMailer < ApplicationMailer

  def daily_digest
    User.all.each do |u|
      @user = u
      @questions = Question.todays
      mail(to: @user.email, subject: 'Daily Digest')
    end  
  end

end

class UserMailer < ApplicationMailer

  def daily_digest
    User.all.each do |u|
      @user = u
      @questions = Question.todays
      mail(to: @user.email, subject: 'Daily Digest')
    end  
  end

  def new_answer_notice_author(user, question)
    @user = user
    @question = question
    mail(to: @user.email, subject: 'Your question was answered!')
  end

end

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[destroy]
  before_action :set_question, only: %i[create destroy]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
    redirect_to question_path(@question)
  end

  def destroy
    if @answer.user == current_user
      @answer.destroy
      redirect_to question_path(@question)
    end
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end

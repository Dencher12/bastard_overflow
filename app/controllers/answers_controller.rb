class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_answer, only: %i[show edit destroy]
  before_action :set_question, only: %i[create new destroy]

  def index
    @answers = Answer.all
  end

  def show; end

  def new
    @answer = Answer.new
  end

  def edit; end

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
class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit]
  before_action :set_question, only: %i[create new]

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

    if @answer.save
      redirect_to question_answer_path(@question, @answer)
    else
      render :edit
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
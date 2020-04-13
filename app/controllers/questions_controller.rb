class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question, only: %i[show edit destroy update]
  after_action :publish_question, only: [:create]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @comment = Comment.new
    @answer.attachments.build
  end

  def new
    @question = Question.new
    @attachment = @question.attachments.build
  end

  def edit; end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    if @question.user == current_user
      @question.destroy
      redirect_to questions_path
    end
  end

  def update
    @question.update(question_params)
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def publish_question
    return if @question.errors.any?

    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/question',
        locals: { question: @question }
      )
    )
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy])
  end
end

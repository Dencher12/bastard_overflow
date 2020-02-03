class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[destroy update mark rate_up rate_down]
  before_action :set_question, only: %i[create destroy update mark]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def destroy
    return unless @answer.user == current_user

    @answer.destroy

    render :update
  end

  def update
    @answer.update(answer_params)
  end

  def mark
    return unless @question.user == current_user

    @question.answers.each do |answer|
      answer.mark = false
      answer.mark = true if answer == @answer
      answer.save
    end

    render :update
  end

  def rate_up
    @answer.rating += 1 if current_user != @answer.user
    @answer.save
    respond_to do |format|
      format.json { render json: @answer, status: :ok }
      format.html
    end
  end

  def rate_down
    @answer.rating -= 1 if current_user != @answer.user
    @answer.save
    json_respond
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :destroy])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def json_respond
    respond_to do |format|
      format.json { render json: @answer }
    end
  end
end

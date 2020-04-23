class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[destroy update mark rate_up rate_down]
  before_action :set_question, only: %i[create destroy update mark]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save

    ActionCable.server.broadcast 'answers', answer: render_answer
  end

  def destroy
    return unless @answer.user == current_user
    @comment = Comment.new
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
    @answer.rating += 1
    rate
  end

  def rate_down
    @answer.rating -= 1
    rate
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def rate
    if current_user != @answer.user
      if @answer.rate_users.include?(current_user)
        render json: { answer_id: @answer.id, error: 'You have already voted' }, status: :method_not_allowed
      else
        @answer.rate_users << current_user
        @answer.save
        render json: @answer, status: :ok
      end
    else
      render json: { answer_id: @answer.id, error: 'You cannot vote for your answer' }, status: :forbidden
    end
  end

  def render_answer
    return if @answer.errors.any?

    ApplicationController.renderer.instance_variable_set(:@env, {
      'HTTP_HOST' => 'localhost:3000',
      'HTTPS' => 'off',
      'REQUEST_METHOD' => 'GET',
      'SCRIPT_NAME' => '',
      'warden' => warden })

    ApplicationController.render(
      partial: 'answers/answer',
      locals: { answer: @answer, question: @question }
    )
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

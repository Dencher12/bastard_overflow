class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[create]
  before_action :set_question, only: %i[create]

  def create
    @comment = @answer.comments.new(comment_params)
    @comment.save

    ActionCable.server.broadcast 'answers', answer: render_answer
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:answer_id])
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
      locals: { answer: @answer, question: @answer.question }
    )
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end

class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  authorize_resource
  
  def create
    comment_type = params[:comment][:comment_type]
    if comment_type == 'question'
      set_question
      @comment = @question.comments.create(comment_params)
      ActionCable.server.broadcast 'comments', comment: render_comment, comment_type: comment_type
    else
      set_answer
      @comment = @answer.comments.create(comment_params)
      ActionCable.server.broadcast 'comments', comment: render_comment, comment_type: comment_type, answer_id: @answer.id
    end  
    
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:answer_id])
  end

  def render_comment
    ApplicationController.renderer.instance_variable_set(:@env, {
      'HTTP_HOST' => 'localhost:3000',
      'HTTPS' => 'off',
      'REQUEST_METHOD' => 'GET',
      'SCRIPT_NAME' => '',
      'warden' => warden })

    ApplicationController.render(
      partial: 'comments/comment',
      locals: { comment: @comment }
    )
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end

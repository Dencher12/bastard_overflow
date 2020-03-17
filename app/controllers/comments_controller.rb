class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[create]

  def create
    @comment = @answer.comments.new(comment_params)
    @comment.save
  end

  private

  def set_answer
    @answer = Answer.find(params[:answer_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end

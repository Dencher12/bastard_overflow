class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attachment

  def destroy
    return unless @attachment.attachable.user == current_user

    @attachment.destroy

    case @attachment.attachable_type
    when 'Question'
      redirect_to @attachment.attachable
    when 'Answer'
      redirect_to @attachment.attachable.question
    end
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end
end

class AddAnswersToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :answers, :question
  end
end

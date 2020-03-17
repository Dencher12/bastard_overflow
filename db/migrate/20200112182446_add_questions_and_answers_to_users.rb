class AddQuestionsAndAnswersToUsers < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :answers, :user
    add_belongs_to :questions, :user
  end
end

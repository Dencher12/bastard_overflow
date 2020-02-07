class CreateUsersRateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :users_rate_answers do |t|
      t.integer :user_id
      t.integer :answer_id
    end
  end
end

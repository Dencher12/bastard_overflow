class AddMarkToAnswers < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :mark, :boolean, default: false
  end
end

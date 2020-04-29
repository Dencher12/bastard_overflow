class CreateAuthhorizations < ActiveRecord::Migration[6.0]
  def change
    create_table :authhorizations do |t|
      t.references :user, index: true
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end

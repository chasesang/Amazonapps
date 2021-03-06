class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true, index: true
      t.references :product, foreign_key: true, index: true
      t.boolean :is_up

      t.timestamps
    end
  end
end

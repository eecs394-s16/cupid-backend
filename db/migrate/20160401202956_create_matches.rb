class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :user_1_id
      t.integer :user_2_id

      t.integer :yes_count, default: 0
      t.integer :no_count, default: 0

      t.timestamps null: false
    end
  end
end

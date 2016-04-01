class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :user_1
      t.integer :user_2

      t.integer :yes_count
      t.integer :no_count

      t.timestamps null: false
    end
  end
end

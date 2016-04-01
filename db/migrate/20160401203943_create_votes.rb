class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user
      t.belongs_to :match
      t.boolean :yes

      t.timestamps null: false
    end
  end
end

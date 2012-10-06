class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :rank_name, null: false

      t.timestamps
    end
    add_index :ranks, :rank_name, unique: true
  end
end

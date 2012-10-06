class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|
      t.string :pair_name, null: false

      t.timestamps
    end
    add_index :pairs, :pair_name, unique: true
  end
end

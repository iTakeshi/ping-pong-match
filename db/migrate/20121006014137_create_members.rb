class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :member_name, null: false
      t.boolean :member_gender, null: false
      t.integer :rank_id, null: false
      t.integer :grade, null: false
      t.integer :type_id
      t.integer :pair_id

      t.timestamps
    end
    add_index :members, :member_name, unique: true
  end
end

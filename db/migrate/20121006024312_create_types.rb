class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :type_name, null: false

      t.timestamps
    end
    add_index :types, :type_name, unique: true
  end
end

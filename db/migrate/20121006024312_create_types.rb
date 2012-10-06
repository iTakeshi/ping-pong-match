# coding: utf-8

class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :type_name, null: false

      t.timestamps
    end
    add_index :types, :type_name, unique: true

    Type.create!(type_name: '不明')
  end
end

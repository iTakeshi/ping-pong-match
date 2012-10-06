# coding: utf-8

class Type < ActiveRecord::Base
  has_many :members
  attr_accessible :type_name

  validates :type_name,
    presence: { message: '戦型名を入力してください。' },
    uniqueness: { message: '同じ名前の戦型が存在します。' }
end

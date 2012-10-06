class Type < ActiveRecord::Base
  attr_accessible :type_name

  validates :type_name,
    presence: { message: '戦型の名前を入力してください。' },
    uniqueness: { message: '同じ名前の戦型が存在します。' }
end

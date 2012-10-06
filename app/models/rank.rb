class Rank < ActiveRecord::Base
  attr_accessible :rank_name

  validates :rank_name,
    presence: { message: 'レベルの名前を入力してください。' },
    uniqueness: { message: '同じ名前のレベルが存在します。' }
end

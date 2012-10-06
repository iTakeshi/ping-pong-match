class Member < ActiveRecord::Base
  attr_accessible :grade, :member_gender, :member_name, :pair_id, :rank_id, :type_id

  validates :grade,
    presence: { message: '期を指定してください。' }

  validates :member_gender,
    presence: { message: '性別を指定してください。' }

  validates :member_name,
    presence: { message: '名前を入力してください。' },
    uniqueness: { message: '同じ名前のメンバーが存在します。重複しない名前を指定してください。', allow_blank: true }

  validates :rank_id,
    presence: { message: 'レベルを指定してください。' }
end

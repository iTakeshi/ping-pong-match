# coding: utf-8

class Member < ActiveRecord::Base
  belongs_to :pair
  belongs_to :rank
  belongs_to :type
  attr_accessible :grade, :member_gender, :member_name, :member_name_yomi, :pair_id, :rank_id, :type_id

  validates :grade,
    presence: { message: '期を指定してください。' }

  validates :member_gender,
    inclusion: { in: [true, false], message: '性別を指定してください。' }

  validates :member_name,
    presence: { message: '名前を入力してください。' },
    uniqueness: { message: '同じ名前のメンバーが存在します。重複しない名前を指定してください。', allow_blank: true }

  validates :member_name_yomi,
    presence: { message: '名前（ふりがな）を入力してください。' },
    format: { with: /^\p{Hiragana}+$/, message: '名前（ふりがな）には全角ひらがなのみ使用できます。', allow_blank: true },
    uniqueness: { message: '同じ名前（ふりがな）のメンバーが存在します。重複しない名前を指定してください。', allow_blank: true }

  validates :rank_id,
    presence: { message: 'レベルを指定してください。' }

  def school_year
    if Time.now.month <= 3
      Time.now.year - self.grade - 1918
    else
      Time.now.year - self.grade - 1917
    end
  end

  def strfgender
    if self.member_gender
      '男'
    else
      '女'
    end
  end
end

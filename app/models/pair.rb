# coding: utf-8

class Pair < ActiveRecord::Base
  has_many :members
  attr_accessible :pair_name

  validates :pair_name,
    presence: true,
    uniqueness: true

  validate_members_count

  def validate_members_count
    errors.add(:members, 'ペアの人数は2人である必要があります。') if members.length != 2
  end
end

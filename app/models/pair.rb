class Pair < ActiveRecord::Base
  attr_accessible :pair_name

  validates :pair_name,
    presence: true,
    uniqueness: true
end

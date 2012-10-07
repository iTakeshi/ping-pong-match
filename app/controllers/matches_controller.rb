class MatchesController < ApplicationController
  def attendance
    @members = Member.order('member_name_yomi ASC')
  end

  def singles
  end
end

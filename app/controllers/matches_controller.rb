class MatchesController < ApplicationController
  def attendance
    @members = Member.order('member_name_yomi ASC')
  end

  def singles
    attendance = cookies['attendance'].split(',')
    attendance.shift
    @matches_m = generate_singles(Member.where(id: attendance, member_gender: true))
    @matches_f = generate_singles(Member.where(id: attendance, member_gender: false))
  end

private
  def generate_singles(members)
    members.sort_by!{rand}
    matches = Array.new
    loop do
      break if members.length < 2
      matches << members.shift(2)
    end
    matches
  end
end

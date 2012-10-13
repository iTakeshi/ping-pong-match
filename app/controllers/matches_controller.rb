# coding: utf-8

class MatchesController < ApplicationController
  def attendance
    @members = Member.order('member_name_yomi ASC')
  end

  def index
  end

  def generate
    attendance = cookies['attendance'].split(',')
    attendance.shift
    male = generate_singles(Member.where(id: attendance, member_gender: true))
    female = generate_singles(Member.where(id: attendance, member_gender: false))
    render json: { '男子' => male, '女子' => female }
  end

private
  def generate_singles(members)
    members.sort_by!{rand}
    matches = Array.new
    loop do
      break if members.length < 2
      matches << members.shift(2).map{|member| member.member_name}
    end
    matches
  end
end

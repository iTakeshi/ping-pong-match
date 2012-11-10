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

    match_type = cookies['match_type']
    match_gender = cookies['match_gender']
    match_rank = cookies['match_rank']

    if match_type == 'singles'
      if match_gender == 'separate'
        if match_rank == 'separate'
          male_1 = generate_singles(Member.where(id: attendance, member_gender: true, rank_id: 1))
          male_2 = generate_singles(Member.where(id: attendance, member_gender: true, rank_id: 2))
          male_3 = generate_singles(Member.where(id: attendance, member_gender: true, rank_id: 3))
          female_1 = generate_singles(Member.where(id: attendance, member_gender: false, rank_id: 1))
          female_2 = generate_singles(Member.where(id: attendance, member_gender: false, rank_id: 2))
          female_3 = generate_singles(Member.where(id: attendance, member_gender: false, rank_id: 3))
          render json: {
            '男子初級' => male_1,
            '男子中級' => male_2,
            '男子上級' => male_3,
            '女子初級' => female_1,
            '女子中級' => female_2,
            '女子上級' => female_3
          }
        elsif match_rank == 'cross'
          # TODO
          render json: { status: :pending }
        else
          male = generate_singles(Member.where(id: attendance, member_gender: true))
          female = generate_singles(Member.where(id: attendance, member_gender: false))
          render json: { '男子' => male, '女子' => female }
        end
      else
        if match_rank == 'separate'
          rank_1 = generate_singles(Member.where(id: attendance, rank_id: 1))
          rank_2 = generate_singles(Member.where(id: attendance, rank_id: 2))
          rank_3 = generate_singles(Member.where(id: attendance, rank_id: 3))
          render json: { '初級' => rank_1, '中級' => rank_2, '上級' => rank_3 }
        elsif match_rank == 'cross'
          # TODO
          render json: { status: :pending }
        else
          render json: { 'ランダム対戦' => generate_singles(Member.where(id: attendance)) }
        end
      end
    end
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

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
          male_1, attendance = generate_singles(Member.where(id: attendance, member_gender: true, rank_id: 1), attendance)
          male_2, attendance = generate_singles(Member.where(id: attendance, member_gender: true, rank_id: 2), attendance)
          male_3, attendance = generate_singles(Member.where(id: attendance, member_gender: true, rank_id: 3), attendance)
          female_1, attendance = generate_singles(Member.where(id: attendance, member_gender: false, rank_id: 1), attendance)
          female_2, attendance = generate_singles(Member.where(id: attendance, member_gender: false, rank_id: 2), attendance)
          female_3, attendance = generate_singles(Member.where(id: attendance, member_gender: false, rank_id: 3), attendance)
          render json: {
            matches: {
              '男子初級' => male_1,
              '男子中級' => male_2,
              '男子上級' => male_3,
              '女子初級' => female_1,
              '女子中級' => female_2,
              '女子上級' => female_3
            },
            rest: Member.where(id: attendance).map{|member| member.member_name}.join(', ')
          }
        elsif match_rank == 'cross'
          # TODO
          render json: { status: :pending }
        else
          male, attendance = generate_singles(Member.where(id: attendance, member_gender: true), attendance)
          female, attendance = generate_singles(Member.where(id: attendance, member_gender: false), attendance)
          render json: { matches: { '男子' => male, '女子' => female }, rest: Member.where(id: attendance).map{|member| member.member_name}.join(', ') }
        end
      else
        if match_rank == 'separate'
          rank_1, attendance = generate_singles(Member.where(id: attendance, rank_id: 1), attendance)
          rank_2, attendance = generate_singles(Member.where(id: attendance, rank_id: 2), attendance)
          rank_3, attendance = generate_singles(Member.where(id: attendance, rank_id: 3), attendance)
          render json: { matches: { '初級' => rank_1, '中級' => rank_2, '上級' => rank_3 }, rest: Member.where(id: attendance).map{|member| member.member_name}.join(', ') }
        elsif match_rank == 'cross'
          # TODO
          render json: { status: :pending }
        else
          random_match, attendance = generate_singles(Member.where(id: attendance), attendance)
          render json: { matches: { 'ランダム対戦' => random_match  }, rest: Member.where(id: attendance).map{|member| member.member_name}.join(', ') }
        end
      end
    end
  end

private
  def generate_singles(members, attendance)
    members.sort_by!{rand}
    matches = Array.new
    loop do
      break if members.length < 2
      match = members.shift(2)
      attendance -= match.map{|member| member.id.to_s}
      matches << match.map{|member| member.member_name}
    end
    p attendance
    return matches, attendance
  end
end

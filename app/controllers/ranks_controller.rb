# coding: utf-8

class RanksController < ApplicationController

  # GET /ranks/new
  def new
    @rank = Rank.new
  end

  # POST /ranks/create
  def create
    @rank = Rank.new(params[:rank])
    if @rank.save
      flash[:success] = "レベル「#{@rank.rank_name}」を作成しました。"
      if params[:commit] == '作成'
        redirect_to ranks_path
      else
        redirect_to new_rank_path
      end
    else
      render :new
    end
  end
end

# coding: utf-8

class RanksController < ApplicationController

  def index
    @ranks = Rank.all
  end

  def show
    @rank = Rank.find(params[:id])
  end

  def new
    @rank = Rank.new
  end

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

  def edit
    @rank = Rank.find(params[:id])
  end

  def update
    @rank = Rank.find(params[:id])
    if @rank.update_attributes(params[:rank])
      flash[:success] = "レベル名を変更しました。"
      redirect_to @rank
    else
      render :edit
    end
  end
end

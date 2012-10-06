# coding: utf-8

class TypesController < ApplicationController

  def index
    @types = Type.all
  end

  def show
    @type = Type.find(params[:id])
  end

  def new
    @type = Type.new
  end

  def create
    @type = Type.new(params[:type])
    if @type.save
      flash[:success] = "戦型「#{@type.type_name}」を作成しました。"
      if params[:commit] == '作成'
        redirect_to types_path
      else
        redirect_to new_type_path
      end
    else
      render :new
    end
  end

  def edit
    @type = Type.find(params[:id])
  end

  def update
    @type = Type.find(params[:id])
    if @type.update_attributes(params[:type])
      flash[:success] = "戦型名を変更しました。"
      redirect_to @type
    else
      render :edit
    end
  end
end

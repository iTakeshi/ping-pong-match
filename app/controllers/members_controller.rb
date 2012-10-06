# coding: utf-8

class MembersController < ApplicationController

  def index
    @members = Member.all
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(params[:member])
    if @member.save
      flash[:success] = "#{@member.member_name}さんをメンバー登録しました。"
      if params[:commit] == '登録'
        redirect_to members_path
      else
        redirect_to new_member_path
      end
    else
      render :new
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(params[:member])
      flash[:success] = "#{@member.member_name}さんの情報を編集しました。"
      redirect_to members_path
    else
      render :edit
    end
  end

  def destroy
    member = Member.find(params[:id])
    member.delete
    flash[:info] = "#{member.member_name}さんを削除しました。"
    redirect_to members_path
  end
end

class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "User"
      @end_users = EndUser.looks(params[:search], params[:word])
    else
      @nails = Nail.published.looks(params[:search], params[:word])
    end
  end
end

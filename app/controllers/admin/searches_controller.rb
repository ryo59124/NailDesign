class Admin::SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "User"
      @end_users = EndUser.looks(params[:search], params[:word])
    else
      @nails = Nail.looks(params[:search], params[:word])
    end
  end
end

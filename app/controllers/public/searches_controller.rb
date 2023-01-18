class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @end_users = EndUser.looks(params[:search], params[:word])
    else
      @nails = Nail.looks(params[:search], params[:word])
    end
  end
end

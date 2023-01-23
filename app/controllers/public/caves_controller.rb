class Public::CavesController < ApplicationController
  def show
    @cafe = Cafe.find(params[:id])
    gon.cafe = @cafe
  end
end

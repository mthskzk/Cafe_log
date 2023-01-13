class Public::CavesController < ApplicationController
  def index
  end

  def show
    @cafe = Cafe.find(params[:id])
  end
end

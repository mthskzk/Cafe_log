class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @cafes = Cafe.where(prefectures: "").page(params[:page])
  end
end

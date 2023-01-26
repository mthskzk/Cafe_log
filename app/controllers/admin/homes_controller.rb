class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @cafes = Cafe.blank_exist.page(params[:page])
  end
end

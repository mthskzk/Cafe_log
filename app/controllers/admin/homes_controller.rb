class Admin::HomesController < ApplicationController
  def top
    @cafes = Cafe.where(prefectures: "")

  end
end

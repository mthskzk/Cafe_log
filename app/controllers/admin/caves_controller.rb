class Admin::CavesController < ApplicationController
  def new
    @cafe = Cafe.new
  end

  def index
    @cafes = Cafe.all
  end

  def show
    @cafe = Cafe.find(params[:id])
  end

  def create
    @cafe = Cafe.new(cafe_params)
    if @cafe.search_blank == true
      if @cafe.save
        redirect_to admin_caves_path
      else
        render :new
      end
    else
      render :new
    end
  end

  def edit
    @cafe = Cafe.find(params[:id])
  end

  def update
    @cafe = Cafe.find(params[:id])
    @cafe.image.attach(params[:image]) if @cafe.image.blank?
    if @cafe.update(cafe_params)
      if @cafe.search_blank == true
        redirect_to admin_cafe_path(@cafe.id)
      else
        render :edit
      end
    else
      render :edit
    end
  end

  def destroy
    @cafe = Cafe.find(params[:id])
    @cafe.destroy
    redirect_to admin_caves_path
  end

  private

  def cafe_params
    params.require(:cafe).permit(:image, :name, :prefectures, :address_after, :nearest_station, :telephone_number, :business_hours, :regular_holiday, :is_deleted)
  end
end

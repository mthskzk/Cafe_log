class Public::KeepCavesController < ApplicationController
  def index
    @customer = current_customer
    keep_cafes = KeepCafe.where(customer_id: @customer.id).pluck(:cafe_id)
    @cafes = Cafe.where(id: keep_cafes)
  end

  def create
    @cafe = Cafe.find(params[:cafe_id])
    keep = current_customer.keep_caves.new(cafe_id: @cafe.id)
    keep.save
    render "replace_keep_cafe"
  end

  def destroy
    @cafe = Cafe.find(params[:cafe_id])
    keep = current_customer.keep_caves.find_by(cafe_id: @cafe.id)
    keep.destroy
    render "replace_keep_cafe"
  end
end

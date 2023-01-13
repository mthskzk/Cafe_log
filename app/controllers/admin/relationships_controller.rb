class Admin::RelationshipsController < ApplicationController
  def followings
    @customer = Customer.find(params[:customer_id])
    @followings = @customer.followings
  end

  def followers
    @customer = Customer.find(params[:customer_id])
    @followers= @customer.followers
  end
end

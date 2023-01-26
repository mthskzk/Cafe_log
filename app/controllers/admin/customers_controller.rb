class Admin::CustomersController < ApplicationController
  # 管理者でログインしているときのみ閲覧可にするメソッド
  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page]).per(3)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id)
    else
      render "edit"
    end
  end

  def destroy
     @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to admin_customers_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :profile_image, :is_deleted)
  end

end

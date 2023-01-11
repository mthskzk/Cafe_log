class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id), notice: "編集に成功しました"
    else
      render "edit"
    end
  end

  # 退会確認ページ
  def unsubscribe
    @customer = current_customer
  end

  # 退会のアクション
  def withdrawal
    @customer = current_customer
    if @customer.update(is_deleted: true)
      sign_out current_customer
    end
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :profile_image)
  end



end

class Admin::DashboardController < ApplicationController

  def index
    @user_count = User.count
    @product_count = Product.count
    @review_count = Review.count
    @products = Product.last(20)
    # @locations = user_json(@users)
    @users = User.all
  end

end

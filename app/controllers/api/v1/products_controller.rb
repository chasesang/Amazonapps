class Api::V1::ProductsController < ApplicationController
before_action :authenticate_user
skip_before_filter :verify_authenticity_token

def index
  @products = Product.all
end

def show
  @product = Product.find params[:id]
  # render json: @product
  # render :show
end

def create
  @product = Product.new title: params[:title], description: params[:description], price: params[:price]
  @product.user = @user
if @product.save
  render json: {result: 'product created'}
else
  render json: {result: @product.errors.full_messages.join(', ')}
end
  end

def destroy
  @product = Product.find params[:id]

  if @product.destroy
    render json: {result: 'product deleted'}
  else
    render json: {result: @product.errors.full_messages.join(', ')}, status: 500
  end
rescue ActiveRecord::RecordNotFound
  render json: {result: 'Product can not be found'}, status: 4041

end

def update
  @product = Product.find params[:id]
end




private
def authenticate_user
  @user = User.find_by_api_token params[:api_token]
  head :unauthorized if @user.nil?
end






end

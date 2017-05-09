class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @product = Product.new
  end

  def create
    product_params = params.require(:product).permit([:title, :description, :price, :category_id])
    @product = Product.new product_params
    @product.user = current_user
    if @product.save
      ProductsMailer.notify_product_owner(@product).deliver_now
      redirect_to products_path
    else
      render :new
  end
  end

  def index
    @products = Product.all
  end

  def show

    @product = Product.find params[:id]
    @review = Review.new

  end

  def destroy
    @product = Product.find params[:id]
    if can? :destroy, @product
     @product.destroy
     redirect_to products_path, notice: 'Product delete'
   else
     redirect_to root_path, alert: 'Access denied'
   end
  end

  def edit
    @product = Product.find params[:id]
    redirect_to root_path, alert: 'access denited' unless can? :edit, @product

  end



  def update
  @product = Product.find params[:id]
  product_params = params.require(:product).permit([:title, :description, :price, :category_id])

  if !(can? :edit, @product)
      redirect_to root_path, alert: 'acess denied'
    elsif @product.update(product_params.merge({ slug:nil}))
      redirect_to product_path(@product), notice: 'Product updated'
    else
      render :edit
    end
end

end

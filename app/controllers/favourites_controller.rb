class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    @products = user.favourited_product
    render 'products/index'
  end


  def create

    product = Product.find params[:product_id]
    if cannot? :favourite, product
      redirect_to(
      product_path(product),
      alert: 'can not favourite your own product'
      )
    return
    end

    favourite = Favourite.new(user: current_user, product: product)
    if favourite.save
      if params['origin'] == 'index'
        redirect_to products_path, notice: 'Product favourited'
      else
        redirect_to product_path(product), notice: 'Product favourited'
      end
    else
      redirect_to product_path(product), alert:
      favourite.errors.full_messages.join(', ')
    end
  end

  def destroy
    favourite = Favourite.find params[:id]
    if favourite.destroy
      if params['origin'] == 'index'
        redirect_to products_path, notice: 'un-favourited!'
      else
        redirect_to product_path(favourite.product), notice: 'un-favourited!'
      end
    else
      edirect_to product_path(favourite.product), alert:
      favourite.errors.full_messages.join(', ')
    end
  end


end

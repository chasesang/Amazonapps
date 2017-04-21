class LikesController < ApplicationController
  before_action :authenticate_user!

  # def index
  #   user = User.find(params[:user_id])
  #   @reviews = user.liked_reviews
  #   @reviews.each do |review|
  #     @product = review.product
  #   end
  #   render 'products/index'
  # end

  def create

    review = Review.find params[:review_id]
    product = review.product
    if cannot? :like, review
      redirect_to(
      product_path(product),
      alert: 'can not like your own review'
      )
      return
    end

    like = Like.new(user: current_user, review: review)

    if like.save
      redirect_to product_path(product), notice: 'thank you for liking!'
    else
      redirect_to product_path(product), alert:  like.errors.full_messages.join(', ')
    end
  end

  def destroy
    like = Like.find(params[:id])

    if like.destroy
    redirect_to product_path(like.review.product), notice: 'like removed!'
    else
    redirect_to product_path(like.review.product), alert:  like.errors.full_messages.join(', ')
    end
  end
end

class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  def create
  @product = Product.find(params[:product_id])
  # puts params

  review_params = params.require(:review).permit(:body, :rating)
  # puts review_params

      @review = Review.new(review_params)
      @review.product = @product
      @review.user = current_user
    


  # @answer = @queston.answers.build(answer_params)

  if @review.save
    ReviewsMailer.notify_review_to_the_product_owner(@review).deliver_now
  redirect_to product_path(@product), notice: 'Review Created!'
  else

    render '/products/show'

  end

end

def destroy
  review = Review.find(params[:id])
  if !(can? :destroy, review)
  redirect_to product_path(review.product), notice: 'access denied!'
  else
  review.destroy
  redirect_to product_path(review.product), notice: 'Review (Test) deleted!'
end
end

def update
  @review = Review.find(params[:id])
  if !(can? :update, @review)
    redirect_to root_path, alert: 'access denied!'
  else
    if @review.is_hidden == false
      @review.update({is_hidden: true})
      redirect_to product_path(@review.product), notice: 'Review is hidden!'
    else
      @review.update({is_hidden: false})
      redirect_to product_path(@review.product), notice: 'Review is back!'
    end
  end
end
end

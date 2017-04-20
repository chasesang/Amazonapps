class ReviewsMailer < ApplicationMailer

  def notify_review_to_the_product_owner(review)

    @review = review
    @product = review.product
    @user = @product.user

    mail(to: @user.email, subject: 'a review has been created for your product!')
    end
end

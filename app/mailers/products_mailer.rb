class ProductsMailer < ApplicationMailer
  def notify_product_owner(product)

    @product = product
    @user = @product.user

    mail(to: @user.email, subject: 'you created a product!')
    end
end

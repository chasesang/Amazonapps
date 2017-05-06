json.id @product.id
json.title @product.title
json.created_on @product.created_at.strftime('%Y-%B-%d')
json.reviews @product.reviews do |review|
  json.id review.id
  json.body review.body
  json.likes review.likes

end

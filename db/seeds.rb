# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Books', 'TV shows', 'Movies', 'Clothse', 'Music', 'Food'].each do |category|
Category.create(name: category)
end


#Create users
20.times do
  User.create(first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                email: Faker::Internet.email,
                password: '12345678',
                password_confirmation: '12345678'
    )
    puts "User created!"
  end

#create Products
100.times do
  category = Category.all.sample
  user = User.all.sample

  Product.create({ title: Faker::Friends.character,
                    description: Faker::Friends.quote,
                    price: rand(100),
                    category_id: category.id,
                    user_id: user.id


                  })
end

products = Product.all

#Create Reviews
products.each do |product|
  rand(0..5).times do
    user = User.all.sample
    product.reviews.create({
      body: Faker::Friends.quote,
      rating: rand(1..5),
      user_id: user.id
      })
  end
end

reviews_count = Review.count
product_count = Product.count

puts Cowsay.say "Created #{product_count}", :cow
puts Cowsay.say "Created #{reviews_count} reviews", :cow

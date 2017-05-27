# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 100.times do
#   User.create first_name: Faker::Name.first_name,
#               last_name: Faker::Name.last_name,
#               email: FFaker::Internet.email
# end
# puts Cowsay.say 'Created 100 in Users', :cow

# Product.where(sale_price: 0).each{|p| p.update(sale_price: p.price)}
# Product.save!

# Product.update_all(sale_price: 0)
Category.destroy_all
Product.destroy_all
Review.destroy_all
User.destroy_all

PASSWORD = 'pass123'

categories = Category.create([
  {name: 'Clothes'},
  {name: 'Furniture'},
  {name: 'Auto'},
  {name: 'Technology'},
  {name: 'Appliances'},
  {name: 'Miscellaneous'}
])

users = User.create([
  {first_name: 'Jon', last_name: 'Snow', email: 'js@winterfell.gov', password: PASSWORD},
  {first_name: 'Daenerys', last_name: 'Targaryan', email: 'daeny@dragon.io', password: PASSWORD},
  {first_name: 'Cersei', last_name: 'Lannister', email: 'cs@iron.throne', password: PASSWORD}
])

100.times do
# puts categories.sample, users.sample
  Product.create title: Faker::Hacker.say_something_smart,
                  description:  Faker::Hipster.paragraph,
                  price: rand(1000),
                  sale_price: rand(700),
                  category_id: categories.sample.id,
                  user_id: users.sample.id

end

products = Product.all

products.each do |x|
  rand(1..5).times do
    Review.create(body: Faker::ChuckNorris.fact, product_id: products.sample.id, rating: rand(1..5), user_id: users.sample.id )
  end
end

puts Cowsay.say "Created #{Product.all.count} Products", :cow
puts Cowsay.say "Created #{Review.all.count} reviews! ð©", :ghostbusters

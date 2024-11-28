# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.delete_all
User.delete_all

3.times do
    user =  User.create! email: Faker::Internet.email, password: 'locadex1234'
    puts "created a new user: #{user.email}"

    2.times do
        product = Product.create!(
            title: Faker::Commerce.product_name,
            price: rand(1.0..100.0),
            published: true,
            user_id: user.id
        )
        puts "Created a brand new product: #{product.title}"
    end
end

require "open-uri"
require 'json'

file = File.read('db/base.json')
data_hash = JSON.parse(file)

puts 'Seed: Deleting existing users...'

# data_hash['root']['products']['product']
hash = data_hash['root']['products']['product'].reject { |h| h['id'] == '' }
puts hash.size

User.destroy_all
puts 'Seed: Creating users...'
user = User.create(email: "admin@mail.ru", password: 'password', admin: true )
puts 'Seed: Users created...'

puts 'Seed: Deleting existing categories...'
Category.destroy_all
puts 'Seed: Creating categories...'

data_hash['root']['categories']['category'].each do |category|
  # file_earrings = URI.open("https://res.cloudinary.com/dygywvyiq/image/upload/v1675418917/earrings_rzmjqk.png")
  cat = Category.new(category_id: category['id'], name: category['name'], parent_id: category['parent_id'], description: 'desc')
  # cat.photo.attach(io: file_earrings, filename: "earrings", content_type: "image/jpg")
  cat.save!
end

puts 'Seed: Category created...'

puts 'Seed: Creating products...'

hash.each do |product|
  next if Category.find_by(category_id: product['categories']['category_id']).nil?
  pro = Product.new(
    product_id: product['id'],
    article: product['article'],
    name: product['product_name'],
    provider: product['provider'],
    description: product['description'].blank? ? 'desc' : product['description'],
    price: product['prices']['price'].nil? ? 0 : product['prices']['price']['value'].to_i,
    quantity: product['qty']['qty_type'].nil? ? 0 : product['qty']['qty_type']['value'].to_i,
    qty_type: product['qty']['qty_type']['name'],
    user: user,
    category: Category.find_by(category_id: product['categories']['category_id'])
  )

  # pro.photos.attach(io: file_1, filename: "into the groove", content_type: "image/jpg")
  pro.save!
end

puts 'Seed: Finished seeding!'

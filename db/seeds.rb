require 'json'
require 'net/ftp'
require "open-uri"
require 'fileutils'

def get_import_file(path, file)
  ftp = Net::FTP.new
  ftp.connect('agromastertver.ru', 21)
  ftp.login('sftp-user1', 'whacky-spiritism-24')
  ftp.chdir(path)
  ftp.passive = true
  ftp.getbinaryfile(file, 'db/import/new_import.xml')
  ftp.close
end

def get_image(path, file)
  ftp = Net::FTP.new
  ftp.connect('agromastertver.ru', 21)
  ftp.login('sftp-user1', 'whacky-spiritism-24')
  ftp.chdir(path)
  ftp.passive = true
  ftp.getbinaryfile(file, 'db/import_images/' + file)
  ftp.close
end

def add_image_to_product(image_url, product)
  matches = image_url.match(/\/([^\/]+\.(jpg|jpeg))$/)
  file = matches[1]
  path = image_url.gsub("/#{file}", '')

  get_image(path, file)

  product.photos.attach(
    io: File.open(File.join(Rails.root, "db/import_images/#{file}")),
    filename: file
  )
end

get_import_file('/upload', '1cToSiteExport.xml')

data_hash = Hash.from_xml(File.read('db/import/new_import.xml'))
hash = data_hash['root']['products']['product'].reject { |h| h['id'] == '' }

# User.destroy_all
puts 'Seed: Creating users...'
# user = User.create!(email: "admin@mail.ru", password: "password", first_name: "Admin", last_name: "User")
user = User.find_or_create_by!(email: "admin@mail.ru", first_name: "Admin", last_name: "User")
puts user.inspect
puts 'Seed: Users created...'

# Config.destroy_all
# puts 'Seed: Creating configs...'
# Config.find_or_create_by!(name: 'mail_to', value: 'agromaster.info@yandex.ru')
# puts 'Seed: Config created...'

# puts 'Seed: Deleting existing categories...'
# Category.destroy_all
# puts 'Seed: Creating categories...'

data_hash['root']['categories']['category'].each do |category|
  status = true
  status = false if category['name'] == 'Разное' || category['name'] == 'Сантехника'

  cat = Category.find_by(
    category_id: category['id'],
    name: category['name'],
    parent_id: category['parent_id']
  )

  if cat
    cat.update!(
      category_id: category['id'],
      name: category['name'],
      parent_id: category['parent_id'],
      description: 'desc',
      status: status
    )
  else
    Category.create!(
      category_id: category['id'],
      name: category['name'],
      parent_id: category['parent_id'],
      description: 'desc',
      status: status
    )
  end

end
puts 'Seed: Category created...'

# puts 'Seed: Deleting existing products...'
# Product.destroy_all
# puts 'Seed: Creating products...'

puts 'Seed: Creating products...'
hash.each do |product|
  category = Category.find_by(category_id: product['categories']['category_id'])
  next if category.nil?

  pro = Product.find_by(
    product_id: product['id'],
    article: product['article'],
    name: product['product_name'],
    provider: product['provider']
  )

  if pro
    pro.update!(
      product_id: product['id'],
      article: product['article'],
      name: product['product_name'],
      provider: product['provider'],
      description: product['description'].blank? ? '' : product['description'],
      price: (product['prices'].nil? || product['prices']['price'].nil?) ? 0 : product['prices']['price']['value'].to_i,
      quantity: product['qty']['qty_type'].nil? ? 0 : product['qty']['qty_type']['value'].to_i,
      qty_type: product['qty']['qty_type']['name'],
      status: true,
      user: user,
      category: category
    )

    photos = product['photo'] unless product['photo'].nil?

    if photos && photos.size > 0

      pro_photos = pro.photos
      if pro_photos && pro_photos.size > 0
        pro_photos.each do |pro_photo|
          pro_photo.purge if pro_photo.present?
        end
      end

      photos.each do |url|
        if url[1].class == String
          add_image_to_product(url[1], pro)
        elsif url[1].class == Array
          url[1].each_with_index do |image_url, index|
            next if index == 0
            add_image_to_product(image_url, pro)
          end
        end
      end
    end
  else
    new_pro = Product.create!(
      product_id: product['id'],
      article: product['article'],
      name: product['product_name'],
      provider: product['provider'],
      description: product['description'].blank? ? '' : product['description'],
      price: (product['prices'].nil? || product['prices']['price'].nil?) ? 0 : product['prices']['price']['value'].to_i,
      quantity: product['qty']['qty_type'].nil? ? 0 : product['qty']['qty_type']['value'].to_i,
      qty_type: product['qty']['qty_type']['name'],
      status: true,
      user: user,
      category: category
    )

    photos = product['photo'] unless product['photo'].nil?

    if photos && photos.size > 0
      photos.each do |url|
        if url[1].class == String
          add_image_to_product(url[1], new_pro)
        elsif url[1].class == Array
          url[1].each_with_index do |image_url, index|
            next if index == 0
            add_image_to_product(image_url, new_pro)
          end
        end
      end
    end
  end
end

Product.find_each do |product|
  product.normalize_friendly_id(product.name)
  product.save
end

old_products = Product.where("updated_at < ?", 1.days.ago)

puts "Count old product: #{old_products.count}"
puts "Seed: Finished seeding! #{Time.now}"
puts "********************************************************************************"

# ADD WaterMark for IMAGES
products = Product.all
products.each do |product|
  photos = product.photos unless product.photos.nil?

  if photos && photos.size > 0
    photos.each do |photo|
      product.apply_watermark(photo)
    end
  end
end
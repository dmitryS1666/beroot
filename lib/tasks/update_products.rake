namespace :update_products do
  desc "Update all products"
  task update_db: :environment do
    filename = Dir[File.join(Rails.root, 'db', 'update_db', "#{ENV['SEED']}.rb")][0]
    puts "Seeding #{filename}..."
    load(filename) if File.exist?(filename)
  end
end

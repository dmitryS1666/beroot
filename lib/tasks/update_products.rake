namespace :update_products do
  desc "Update all products"
  task update_db: :environment do
    load Rails.root + "db/seeds.rb"
  end
end

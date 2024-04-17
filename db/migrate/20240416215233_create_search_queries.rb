class CreateSearchQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :search_queries do |t|
      t.string :query
      t.string :desc

      t.timestamps
    end
  end
end

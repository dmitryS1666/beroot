class CreateAboutSliders < ActiveRecord::Migration[7.0]
  def change
    create_table :about_sliders do |t|
      t.string :video_link

      t.timestamps
    end
  end
end

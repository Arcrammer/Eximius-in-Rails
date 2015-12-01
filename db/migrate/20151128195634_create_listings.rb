class CreateListings < ActiveRecord::Migration
  def up
    create_table :listings do |t|
      t.string :location
      t.string :title
      t.string :location
      t.integer :business_id
      t.string :body_filename
      t.timestamps null: false
    end
  end

  def down
    drop_table :listings
    # Delete all of the listing bodies
    FileUtils.rm_rf(Dir.glob(Rails.root.join('public', 'listing_bodies', '*')))
  end
end

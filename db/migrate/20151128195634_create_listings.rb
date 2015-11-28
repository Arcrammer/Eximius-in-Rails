class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :location
      t.string :title
      t.string :body_filename
      t.timestamps null: false
    end
  end
end

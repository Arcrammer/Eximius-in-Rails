class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :business
      t.timestamps null: false
    end
  end
end

# 20151125205238_create_users.rb
#
# Eximius
# Alexander Rhett Crammer
# Advanced Server-Side Languages
# Full Sail University
# Created Wednesday, 25 Nov. 2015
#
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email_address
      t.string :password_digest
      t.boolean :is_employer
      t.boolean :is_seeker
      t.string :cv_filename
      t.string :selfie_filename
      t.timestamps null: false
    end
  end
end

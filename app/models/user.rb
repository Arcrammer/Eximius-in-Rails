# user.rb
#
# Eximius
# Alexander Rhett Crammer
# Advanced Server-Side Languages
# Full Sail University
# Created Wednesday, 25 Nov. 2015
#
class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: {
    message: 'What\'s your username going to be?',
    on: :create
  }
  validates :username, uniqueness: {
    message: 'Someone has already chosen that username.',
    on: :create
  }
  validates :email_address, uniqueness: {
    message: 'Someone has already used that email address.',
    on: :create
  }
  validates :password, presence: {
    message: 'You need a password to prove your identity.',
    on: :create
  }
  validates :password, length: {
    within: 6..28,
    too_short: "Use #{count} or more characters in your password.",
    too_long: "Use less than #{count} characters in your password, please.",
    on: :create
  }
  validates :password_confirmation, presence: {
    message: 'Please verify your password',
    on: :create
  }
end

# routes.rb
#
# Eximius
# Alexander Rhett Crammer
# Advanced Server-Side Languages
# Full Sail University
# Created Wednesday, 25 Nov. 2015
#
Rails.application.routes.draw do
  # Welcome
  root 'welcome#index'

  # Authentication
  get '/auth/register' => 'users#create'
  get '/auth/login' => 'users#login'
  post '/auth/login' => 'users#login'
  get '/auth/logout' => 'users#logout'
  post '/auth/register' => 'users#persist'
end

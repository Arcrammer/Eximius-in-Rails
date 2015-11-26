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
  get '/register' => 'users#create'
  get '/logout' => 'users#logout'
  post '/register' => 'users#persist'
end

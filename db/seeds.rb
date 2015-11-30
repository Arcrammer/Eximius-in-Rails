# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users
User.create({
  username: 'iAlexander',
  email_address: 'Alexander2475914@gmail.com',
  password: 'secret',
  password_confirmation: 'secret',
  is_employer: 1,
  is_seeker: 1,
  created_at: Time.now.to_s(:db),
  updated_at: Time.now.to_s(:db)
})

# Businesses
businesses = [
  'Ullmannite',
  'T5 Labs',
  'Expa',
  'The New York Times',
  'Wall Street Journal',
  'Meetup',
  'Amazon, Inc.',
  'Blue Apron',
  'Audible, Inc.',
  'Condé Nast',
  'Shutterfly',
  'Adobe',
  'Smith & Keller',
  'TIME Magazine',
  'Grid'
]

businesses.each do |b|
  Business.create({
    name: b
  })
end

# Listings
possible_locations = [
  'Chelsea, Manhattan',
  'Williamsburg, Brooklyn',
  'SoHo, Manhattan',
  'Upper East Side, Manhattan',
  'Red Hook, Brooklyn',
  'Kips Bay, Manhattan',
  'Astoria, Queens',
  'Midtown, Manhattan'
];

possible_title_intros = [
  'Urgent Need of',
  'Start-up Looking for',
  'Local Studio Needs',
  'Large Team Looking for'
]

possible_positions = [
  # 'Urgent Need of...'
  #
  # Please use Title Case (that
  # doesn't mean to capitalise
  # each word)
  #
  'an iOS Architect',
  'an Android Engineer',
  'a C++ Developer',
  'a Database Administrator',
  'a Java Programmer',
  'a Ruby Developer',
  'a PHP Developer',
  'a Python Engineer'
];

100.times do |t|
  listing = Listing.create({
    title: possible_title_intros.sample + ' ' + possible_positions.sample,
    body_filename: (0...50).map { ('a'..'z').to_a[rand(26)] }.join + '.html',
    location: possible_locations.sample
  })
  listing_body = File.open(Rails.root.join('public', 'listing_bodies', listing.body_filename), 'wb') do |b|
    b.write(File.read(Rails.root.join('db', 'listing_bodies.html.erb')))
  end
end

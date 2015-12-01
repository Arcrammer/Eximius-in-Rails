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
    business: b
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

# Maximum age listings can be once seeded
earliest_creation_date = Time.now() - 60 * 60 * 24 * 7 * 2
creationOfThisPost = Time.at((Time.now().to_f - earliest_creation_date.to_f) * rand + earliest_creation_date.to_f)

1000.times do |t|
  listing = Listing.create({
    title: possible_title_intros.sample + ' ' + possible_positions.sample,
    body_filename: (0...50).map { ('a'..'z').to_a[rand(26)] }.join + '.html',
    business_id: rand(1..businesses.count),
    location: possible_locations.sample,
    created_at: creationOfThisPost,
    updated_at: creationOfThisPost
  })
  listing_body = File.open(Rails.root.join('public', 'listing_bodies', listing.body_filename), 'wb') do |b|
    b.write(File.read(Rails.root.join('db', 'listing_bodies.html.erb')))
  end
end

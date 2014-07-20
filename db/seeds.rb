# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
me = User.new(
    name: "Master Yoda",
    email: "admin@example.com",
    password: "123123123",
    password_confirmation: "123123123"
  )

me.skip_confirmation!

me.save!

10.times do 
  Domain.create(
    name: Faker::Internet.domain_name,
    url:  Faker::Internet.url,
    user: me,
    active: true
    )
end
domains = Domain.all

events_names = ["users_joined", "page_viewed", "clicks"]
500.times do 
  Event.create(
    name: events_names.sample,
    data: {"test" => true},
    uri:  Faker::Internet.url,
    domain: domains.sample,
    created_at: (rand*7).weeks.ago
    )
end
events = Event.all

puts "Seed finished"
puts "#{Domain.count} domains created"
puts "#{Event.count} events created"
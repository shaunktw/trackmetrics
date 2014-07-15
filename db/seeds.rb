# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
50.times do 
  Domain.create(
    name: Faker::Internet.domain_name,
    url:  Faker::Internet.url
    )
end
domains = Domain.all

50.times do 
  Event.create(
    name: Faker::Internet.name,
    data: Hash[*Faker::Lorem.words(4)],
    uri:  Faker::Internet.url
    )
end
events = Event.all

puts "Seed finished"
puts"#{Domain.count} domains created"
puts"#{Event.count} events created"
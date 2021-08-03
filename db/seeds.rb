# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "Seeding data now!"
IgUser.create_or_find_by({"id" => 41534925199, "name" => "The Table Top", "username" => "thet_abletop", "profile_pic_url" => "pic-link"})
puts("added user!")

file = File.join(Rails.root, 'app', 'helpers', 'seed_data', 'data.json')
data = JSON.parse(File.read(file))

# Follower data to be initialized
followers = data["followers"]

IgUser.add_many(followers)

Record.dynamic_followers(followers)
Record.static_followers(followers)


# Following data to be initialized
followings = data["followings"]

IgUser.add_many(followings)

Record.dynamic_following(followings)
Record.static_following(followings)


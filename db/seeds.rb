# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Admin",
             password:              "Foo Bar ",
             password_confirmation: "Foo Bar ",
             state: 1)

99.times do |n|
  name = "Example #{n}"
  password = "password"
  User.create!(name: name,
               password:              password,
               password_confirmation: password)
end

Topic.create!(name: "Flow")
Topic.create!(name: "综合")
Topic.create!(name: "动漫")
Topic.create!(name: "时报")
Topic.create!(name: "技术")

def post_initialize(topic_name)
  50.times do |_|
    user = User.first
    topic = Topic.find_by(name: topic_name)
    content = topic_name
    title   = "#{topic_name}里的"
    user.posts.create!(content: content, topic: topic, title: title)
  end
end

post_initialize("综合")
post_initialize("动漫")
post_initialize("时报")
post_initialize("技术")
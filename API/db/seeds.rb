# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Admin",
  password:              "password",
  password_confirmation: "password",
             admin: true)

Creator.create!(username:  "T-Man",
  fname:                 "Tobias",
  lname:                 "Hanson",
  password:              "123456",
)

Creator.create!(username:  "S-Girl",
  fname:                 "Sandra",
  lname:                 "Holst",
  password:              "qwerty",
)

Creator.create!(username:  "E-Boy",
  fname:                 "Erik",
  lname:                 "Ledstrom",
  password:              "ilovecandy",
)

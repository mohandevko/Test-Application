# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new(:email => "admin@gmail.com",:password => "password",:password_confirmation => "password",:role => "admin",:username => "admin123",:approved => true)
user.save(:validate => false)
user.confirm!
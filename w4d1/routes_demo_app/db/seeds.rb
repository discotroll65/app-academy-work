# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

kevin = User.create!(username: 'kevin')
garrett = User.create!(username: 'garrett')
won_woman = User.create!(username: 'wonder woman')

kevin.contacts << Contact.new(name: 'Garrett', email: 'Whatap@kdjl.com')
kevin.contacts << Contact.new(name: 'joe', email: 'Whatap@joe.com')
kevin.contacts << Contact.new(name: 'alana', email: "ladyalana@lskdj.com")
won_woman.contacts << Contact.new(name: 'Garrett', email: 'Whatap@kdjl.com')
garrett.contacts << Contact.new(name: 'wonder_woman', email: 'attractive@lady.com')


ContactShare.create!(contact_id: 5, user_id: 1)
ContactShare.create!(contact_id: 3, user_id: 2)

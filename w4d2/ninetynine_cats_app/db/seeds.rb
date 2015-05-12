# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.create!(
birth_date: 2,
color: "white",
name: "kiki",
sex: 'm',
description: 'Kiki is the best ever. He is white furred'
)

Cat.create!(
birth_date: 5,
color: "orange",
name: "sunny",
sex: 'm',
description: 'Sunny was my first cat. He is a male'
)

Cat.create!(
birth_date: 14,
color: "calico",
name: "Maranda",
sex: 'f',
description: 'Maranda is older than the mountains. She has digestion problems'
)

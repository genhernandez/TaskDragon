# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dragons = Team.create!(:name => 'TaskDragon')
#dragons = Team.create!(:name => 'TaskDragon')
Dragon.create!(:name => 'Dragon', :picture_path => 'whatever', :xp => 0, :level => 0, :team => Team.find(1))

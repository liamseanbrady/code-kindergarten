# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

report_card = ReportCard.create(title: 'SQL in Ruby', session_length: 100, grade: 'B', description: 'This is awesome, man. Really cool!')

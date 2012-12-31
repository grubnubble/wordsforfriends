# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

### test data

users = User.create([
  { name: 'Matthew', pass: 'test', email: 'matt@test.com', username: 'matthew' },
  { name: 'Joe', pass: 'test', email: 'joe@test.com', username: 'joe' },
  { name: 'Tamara', pass: 'test', email: 'tamara@test.com', username: 'tamara' },
  { name: 'Richard', pass: 'test', email: 'rich@test.com', username: 'richard' },
  { name: 'Elaine', pass: 'test', email: 'elaine@test.com', username: 'elaine' }])

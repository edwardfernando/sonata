# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.delete_all

Role.create(name: 'Pianis Paduan Suara', created_at: DateTime.now, updated_at: DateTime.now)
Role.create(name: 'Guitaris', created_at: DateTime.now, updated_at: DateTime.now)
Role.create(name: 'Bassis', created_at: DateTime.now, updated_at: DateTime.now)
Role.create(name: 'Usher', created_at: DateTime.now, updated_at: DateTime.now)
Role.create(name: 'WL', created_at: DateTime.now, updated_at: DateTime.now)
Role.create(name: 'Keyboardis', created_at: DateTime.now, updated_at: DateTime.now)
Role.create(name: 'AV', created_at: DateTime.now, updated_at: DateTime.now)
Role.create(name: 'Pianis Ibadah', created_at: DateTime.now, updated_at: DateTime.now)

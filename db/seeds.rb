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

Person.delete_all
Person.create(id: '1',
    email: 'edward.fer@gmail.com',
    name: 'Edward Fernando/Admin',
    provider: 'facebook',
    uid: '733980098',
    oauth_token: 'CAACkhqIY8uUBAMBt1AZAXJ5iaGrCFAxYo8PFvUZC3KMdKiLQZBaJ03N6fIx7h0cpLWd7hFAWgIxSFebvPd6e3x1siroqiYXMjkRs1DgvPiCMEim5MUNRVZCJNhXmbsozUMg6HUtxdakkkKktfIoXVk6qJYTSZBZAwfQJZCZCiFXt9VeXh58b0JUn17pU61UJRhpqGvXgLNZALV1N9h2azCRgZC',
    oauth_expires_at: '2014-09-22 13:37:11.000000',
    avatar_url: 'http://graph.facebook.com/733980098/picture',
    random_id: 'exSh-',
    phone_number_1: '0817211431',
    is_approved: 1,
    approved_date: '2001-01-01 07:00:00',
    role: 2)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create name: 'guest',    title: 'Гость'
Role.create name: 'account',  title: 'Эккаунт'
Role.create name: 'admin',    title: 'Администратор'
Role.create name: 'sysadmin', title: 'Системный администратор'

Product.create name: 'PC', title: 'ПК', description: 'Это есть ПК для тестирования.\nДемо образец', price: 1250.00

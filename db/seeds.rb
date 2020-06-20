# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = Employee.create(fName: 'Store', lName: 'Admin', phone: '9876543210', email: 'admin@store.com', dob: Date.parse('1990-05-28'), address: 'I sleep at the store.')

User.create(password: 'password', employee: admin, admin: true)
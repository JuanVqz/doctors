# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Hospitals
puts "Creating Hospitals"
hospital_uno = Hospital.where(name: "Primero", subdomain: "uno", description: "Una descripcion para el primer hospital.").first_or_create
hospital_dos = Hospital.where(name: "Segundo", subdomain: "dos", description: "Una descripcion para el segudo hospital.").first_or_create

# Doctors
puts "Creating Doctors"
Doctor.create(name: "Pedro Primero", first_name: "Ramírez", last_name: "Sánchez", specialty: "Cirujano Plastico", email: "pedrouno@gmail.com", password: "123456", password_confirmation: "123456", confirmed_at: Time.now, hospital_id: hospital_uno.id)
Doctor.create(name: "Pedro Segundo", first_name: "Santos", last_name: "Pérez", specialty: "Cirujano Dentista", email: "pedrodos@gmail.com", password: "123456", password_confirmation: "123456", confirmed_at: Time.now, hospital_id: hospital_dos.id)

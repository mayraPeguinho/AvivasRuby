# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin_role = Role.create(name: 'Administrador')
gerente_role = Role.create(name: 'Gerente')
empleado_role = Role.create(name: 'Empleado')

user=User.create(
  email: 'admin@gmail.com',
  password: 'admin123',
  alias: 'admin_alias',
  tel: '123456789',
  entry_date: Date.today,
  role: admin_role
)

if user.persisted?
    puts "Usuario creado correctamente."
  else
    puts "Error al crear el usuario: #{user.errors.full_messages}"
  end
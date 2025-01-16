# This file ensures the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create roles
admin_role = Role.create(name: 'Administrator')
gerente_role = Role.create(name: 'Manager')
empleado_role = Role.create(name: 'Employee')

user = User.create(
  email: 'admin@gmail.com',
  password: 'admin123',
  alias: 'admin_alias',
  tel: '123456789',
  entry_date: Date.today,
  role: admin_role
)

if user.persisted?
  puts "User created successfully."
else
  puts "Error creating user: #{user.errors.full_messages}"
end

# Create colors
colors = %w[Red Green Blue Yellow Orange Purple Pink White Black Gray Brown]
colors.each do |color_name|
  Color.create(name: color_name)
end

puts "Colors created successfully."

# Create categories
categories = %w[Sportswear Activewear Gymwear Outdoor\ Gear Training\ Clothes Running\ Gear Cycling\ Apparel Yoga\ Wear Basketball\ Apparel Football\ Wear Tennis\ Apparel Swimming\ Gear]
categories.each do |category_name|
  Category.create(name: category_name)
end

puts "Categories created successfully."

# Create sizes
sizes = %w[Small Medium Large Extra\ Large]
sizes.each do |size_name|
  Size.create(name: size_name)
end

puts "Sizes created successfully."

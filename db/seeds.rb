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

# Create products
products = [
  { name: "Running T-Shirt", description: "Light and breathable t-shirt for running.", unit_price: 29.99, available_stock: 100, category_name: "Running Gear", size_name: "Medium", color_name: "Red", image_filename: "running_t-shirt_image.jpg" },
  { name: "Yoga Pants", description: "Comfortable and flexible pants for yoga practice.", unit_price: 39.99, available_stock: 80, category_name: "Yoga Wear", size_name: "Large", color_name: "Blue", image_filename: "yoga_pants_image.jpg" },
  { name: "Basketball Shorts", description: "Basketball shorts, ideal for training and games.", unit_price: 24.99, available_stock: 60, category_name: "Basketball Apparel", size_name: "Large", color_name: "White", image_filename: "basketball_shorts_image.jpeg" },
  { name: "Training Jacket", description: "Light jacket for outdoor training sessions.", unit_price: 49.99, available_stock: 50, category_name: "Sportswear", size_name: "Extra Large", color_name: "Black", image_filename: "training_jacket_image.jpeg" },
  { name: "Sports Pants", description: "Sports pants ideal for workouts and outdoor activities.", unit_price: 34.99, available_stock: 70, category_name: "Activewear", size_name: "Medium", color_name: "Black", image_filename: "sports_pants_image.jpg" }
]

products.each do |product_data|
  category = Category.find_by(name: product_data[:category_name])
  size = Size.find_by(name: product_data[:size_name])
  color = Color.find_by(name: product_data[:color_name])

  # Verificar si la imagen existe antes de crear el producto
  image_path = Rails.root.join("app", "assets", "images", product_data[:image_filename])

  if File.exist?(image_path)
    # Crear el producto y adjuntar la imagen durante la creación
    product = Product.create(
      name: product_data[:name],
      description: product_data[:description],
      unit_price: product_data[:unit_price],
      available_stock: product_data[:available_stock],
      inventory_entry_date: Date.today,
      category: category,
      size: size,
      color: color
    ) do |product|
      # Adjuntar la imagen al producto inmediatamente después de su creación
      product.images.attach(io: File.open(image_path), filename: product_data[:image_filename])
    end

    if product.persisted?
      # Verificación de que la imagen se adjuntó correctamente
      if product.images.attached?
        puts "Product and image created successfully for #{product.name}"
      else
        puts "Failed to attach image for product #{product.name}"
      end
    else
      puts "Failed to create product: #{product.errors.full_messages.join(", ")}"
    end
  else
    # Si la imagen no existe, no se crea el producto
    puts "Image not found for #{product_data[:name]}. Product not created."
  end
end

puts "Products creation process finished."

# Create roles
admin_role = Role.find_or_create_by(name: 'Administrator')
manager_role = Role.find_or_create_by(name: 'Manager')
employee_role = Role.find_or_create_by(name: 'Employee')

# Create administrators
3.times do |i|
  User.create!(
    email: "admin#{i + 1}@example.com",
    password: "adminRol#{i + 1}",
    alias: "admin_alias_#{i + 1}",
    tel: "12345678#{i}",
    entry_date: Date.today - (i * 10).days,
    role: admin_role
  )
end

# Create managers
4.times do |i|
  User.create!(
    email: "manager#{i + 1}@example.com",
    password: "manager#{i + 1}",
    alias: "manager_alias_#{i + 1}",
    tel: "22345678#{i}",
    entry_date: Date.today - (i * 15).days,
    role: manager_role
  )
end

# Create employees
3.times do |i|
  User.create!(
    email: "employee#{i + 1}@example.com",
    password: "employee#{i + 1}",
    alias: "employee_alias_#{i + 1}",
    tel: "32345678#{i}",
    entry_date: Date.today - (i * 20).days,
    role: employee_role
  )
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
  { name: "Running T-Shirt", description: "Light and breathable t-shirt for running.", unit_price: 29.99, available_stock: 100, category_name: "Running Gear", size_name: "Medium", color_name: "Red", image_filenames: ["running_t-shirt_image.jpg"] },
  { name: "Yoga Pants", description: "Comfortable and flexible pants for yoga practice.", unit_price: 39.99, available_stock: 80, category_name: "Yoga Wear", size_name: "Large", color_name: "Blue", image_filenames: ["yoga_pants_image.jpg"] },
  { name: "Basketball Shorts", description: "Basketball shorts, ideal for training and games.", unit_price: 24.99, available_stock: 60, category_name: "Basketball Apparel", size_name: "Large", color_name: "White", image_filenames: ["basketball_shorts_image.jpeg"] },
  { name: "Training Jacket", description: "Light jacket for outdoor training sessions.", unit_price: 49.99, available_stock: 50, category_name: "Sportswear", size_name: "Extra Large", color_name: "Black", image_filenames: ["training_jacket_image.jpeg"] },
  { name: "Sports Pants", description: "Sports pants ideal for workouts and outdoor activities.", unit_price: 34.99, available_stock: 70, category_name: "Activewear", size_name: "Medium", color_name: "Black", image_filenames: ["sports_pants_image.jpg"] },

  # Two products with two images
  { name: "Advanced Running Shoes", description: "High-performance shoes for serious runners.", unit_price: 79.99, available_stock: 40, category_name: "Running Gear", size_name: "Medium", color_name: "Red", image_filenames: ["running_shoes_1.png", "running_shoes_2.png"] },
  { name: "Yoga Mat", description: "Extra thick mat for comfort and stability.", unit_price: 29.99, available_stock: 90, category_name: "Yoga Wear", size_name: "One Size", color_name: "Green", image_filenames: ["yoga_mat_1.jpg", "yoga_mat_2.jpg"] },

  # Two products with three images
  { name: "Basketball Shoes", description: "Durable shoes for basketball enthusiasts.", unit_price: 89.99, available_stock: 30, category_name: "Basketball Apparel", size_name: "Large", color_name: "Pink", image_filenames: ["basketball_shoes_1.png", "basketball_shoes_2.png", "basketball_shoes_3.png"] },
  { name: "Sports Jacket", description: "Stylish jacket perfect for outdoor training.", unit_price: 59.99, available_stock: 60, category_name: "Sportswear", size_name: "Medium", color_name: "Red", image_filenames: ["sports_jacket_1.jpg", "sports_jacket_2.jpg", "sports_jacket_3.jpg"] }
]

# Crear productos
products = [
  { name: "Running T-Shirt", description: "Light and breathable t-shirt for running.", unit_price: 29.99, available_stock: 100, category_name: "Running Gear", size_name: "Medium", color_name: "Red", image_filenames: ["running_t-shirt_image.jpg"] },
  { name: "Yoga Pants", description: "Comfortable and flexible pants for yoga practice.", unit_price: 39.99, available_stock: 80, category_name: "Yoga Wear", size_name: "Large", color_name: "Blue", image_filenames: ["yoga_pants_image.jpg"] },
  { name: "Basketball Shorts", description: "Basketball shorts, ideal for training and games.", unit_price: 24.99, available_stock: 60, category_name: "Basketball Apparel", size_name: "Large", color_name: "White", image_filenames: ["basketball_shorts_image.jpeg"] },
  { name: "Training Jacket", description: "Light jacket for outdoor training sessions.", unit_price: 49.99, available_stock: 50, category_name: "Sportswear", size_name: "Extra Large", color_name: "Black", image_filenames: ["training_jacket_image.jpeg"] },
  { name: "Sports Pants", description: "Sports pants ideal for workouts and outdoor activities.", unit_price: 34.99, available_stock: 70, category_name: "Activewear", size_name: "Medium", color_name: "Black", image_filenames: ["sports_pants_image.jpg"] },

  # Productos con dos imágenes
  { name: "Advanced Running Shoes", description: "High-performance shoes for serious runners.", unit_price: 79.99, available_stock: 40, category_name: "Running Gear", size_name: "Medium", color_name: "Red", image_filenames: ["running_shoes_1.png", "running_shoes_2.png"] },
  { name: "Yoga Mat", description: "Extra thick mat for comfort and stability.", unit_price: 29.99, available_stock: 90, category_name: "Yoga Wear", size_name: "One Size", color_name: "Green", image_filenames: ["yoga_mat_1.jpg", "yoga_mat_2.jpg"] },

  # Productos con tres imágenes
  { name: "Basketball Shoes", description: "Durable shoes for basketball enthusiasts.", unit_price: 89.99, available_stock: 30, category_name: "Basketball Apparel", size_name: "Large", color_name: "Pink", image_filenames: ["basketball_shoes_1.png", "basketball_shoes_2.png", "basketball_shoes_3.png"] },
  { name: "Sports Jacket", description: "Stylish jacket perfect for outdoor training.", unit_price: 59.99, available_stock: 60, category_name: "Sportswear", size_name: "Medium", color_name: "Red", image_filenames: ["sports_jacket_1.jpg", "sports_jacket_2.jpg", "sports_jacket_3.jpg"] }
]

products.each do |product_data|
  category = Category.find_by(name: product_data[:category_name])
  size = Size.find_by(name: product_data[:size_name])
  color = Color.find_by(name: product_data[:color_name])

  # Verificar si todas las imágenes existen antes de crear el producto
  all_images_exist = product_data[:image_filenames].all? do |image_filename|
    image_path = Rails.root.join("app", "assets", "images", image_filename)
    File.exist?(image_path)
  end

  if all_images_exist
    # Crear el producto sin imágenes inicialmente
    product = Product.new(
      name: product_data[:name],
      description: product_data[:description],
      unit_price: product_data[:unit_price],
      available_stock: product_data[:available_stock],
      inventory_entry_date: Date.today,
      category: category,
      size: size,
      color: color
    )

    # Adjuntar todas las imágenes al producto
    product_data[:image_filenames].each do |image_filename|
      image_path = Rails.root.join("app", "assets", "images", image_filename)
      product.images.attach(io: File.open(image_path), filename: image_filename)
    end

    # Guardar el producto con las imágenes adjuntadas
    if product.save
      puts "Product and images created successfully for #{product.name}"
    else
      puts "Failed to create product: #{product.errors.full_messages.join(", ")}"
    end
  else
    # Si alguna imagen no existe, mostrar mensaje y no crear el producto
    missing_images = product_data[:image_filenames].select do |image_filename|
      image_path = Rails.root.join("app", "assets", "images", image_filename)
      !File.exist?(image_path)
    end
    puts "Missing images for #{product_data[:name]}: #{missing_images.join(', ')}. Product not created."
  end
end

puts "Products creation process finished."

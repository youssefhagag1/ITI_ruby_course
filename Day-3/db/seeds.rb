# Create a default admin user
User.find_or_create_by!(email_address: "admin@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
end

puts "Created admin user: admin@example.com / password"

# Create sample products
products = [
  { name: "T-Shirt", description: "A comfortable cotton t-shirt.", price: 19.99 },
  { name: "Jeans", description: "Classic blue denim jeans.", price: 49.99 },
  { name: "Sneakers", description: "Lightweight running sneakers.", price: 89.99 },
]

products.each do |attrs|
  Product.find_or_create_by!(name: attrs[:name]) do |p|
    p.description = attrs[:description]
    p.price = attrs[:price]
  end
end

puts "Seeded #{Product.count} products."

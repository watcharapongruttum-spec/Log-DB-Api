puts "🔥 Cleaning database..."

# ======================
# CLEAR DATA (order matters)
# ======================
AuditLog.delete_all
Product.delete_all
Category.delete_all
Employee.delete_all
User.delete_all
ActionType.delete_all

# Reset PK sequence (PostgreSQL)
ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.reset_pk_sequence!(table)
end

puts "🧹 Database cleaned"

# ======================
# USERS
# ======================
users = User.create!([
  {
    name: "Admin",
    email: "admin@example.com",
    role: "admin",
    password: "password",
    password_confirmation: "password"
  },
  {
    name: "Staff",
    email: "staff@example.com",
    role: "staff",
    password: "password",
    password_confirmation: "password"
  }
])

puts "✅ Users: #{User.count}"

# ======================
# EMPLOYEES
# ======================
employees = Employee.create!([
  { name: "John Doe", position: "Manager" },
  { name: "Jane Smith", position: "Sales" },
  { name: "Mike Brown", position: "Warehouse" }
])

puts "✅ Employees: #{Employee.count}"

# ======================
# CATEGORIES
# ======================
categories = Category.create!([
  { name: "Electronics" },
  { name: "Furniture" },
  { name: "Stationery" }
])

puts "✅ Categories: #{Category.count}"

# ======================
# PRODUCTS
# ======================
products = Product.create!([
  { name: "Laptop", price: 25000, category: categories[0] },
  { name: "Smartphone", price: 18000, category: categories[0] },
  { name: "Monitor", price: 7000, category: categories[0] },

  { name: "Office Chair", price: 4500, category: categories[1] },
  { name: "Desk", price: 8000, category: categories[1] },

  { name: "Notebook", price: 50, category: categories[2] },
  { name: "Pen", price: 20, category: categories[2] }
])

puts "✅ Products: #{Product.count}"



ActionType.create!([
  { code: 1, name: "CREATE" },
  { code: 2, name: "READ"   },
  { code: 3, name: "UPDATE" },
  { code: 4, name: "DELETE" },
  { code: 5, name: "LOGIN" },
  { code: 6, name: "LOGOUT" }
])


puts "🎉 Seed completed successfully!"

# db/seeds.rb

# Create super admin user
admin = User.create!(
  name: "Primary System Administrator",
  email: "superadmin@example.com",
  password: "SecurePass!456",
  password_confirmation: "SecurePass!456",
  address: "321 Admin Lane, Capital City, CC 54321",
  role: :system_admin
)
puts "Super admin user created"

# Create premier store owner
store_owner = User.create!(
  name: "Premier Store Owner Account",
  email: "premier_owner@example.com",
  password: "SecurePass!456",
  password_confirmation: "SecurePass!456",
  address: "654 Business Blvd, Commerce City, CC 98765",
  role: :store_owner
)
puts "Store owner created"

# Create regular customer user
normal_user = User.create!(
  name: "Regular Customer User Account",
  email: "customer@example.com",
  password: "SecurePass!456",
  password_confirmation: "SecurePass!456",
  address: "987 Customer Circle, Residential City, RC 19283",
  role: :normal_user
)
puts "Normal user created"

# Create a store for the owner
store = Store.create!(
  name: "Amazing Retail Outlet",
  email: "retail@example.com",
  address: "202 Retail Street, Shopping City, SC 30303",
  owner: store_owner
)
puts "Store created"

# Create a rating from the normal user for the store
Rating.create!(
  user: normal_user,
  store: store,
  value: 5
)
puts "Rating created"


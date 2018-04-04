Item.destroy_all

10.times do |i|
  item_attributes = { name: Faker::Name.name, price: Faker::Number.number }
  Item.create! item_attributes
end

User.destroy_all
User.create email: "user@gmail.com", name: "First User", password: "password123"

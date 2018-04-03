Item.destroy_all

10.times do |i|
  item_attributes = { name: Faker::Name.name, price: Faker::Number.number }
  Item.create! item_attributes
end

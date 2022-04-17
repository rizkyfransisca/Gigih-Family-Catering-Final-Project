FactoryBot.define do
  factory :order do
    customer_email { "rizky.royal@gmail.com" }
    total_price { 0 }
    order_date { "01/01/2022" }
    status {"NEW"}
    menus {
      [
        Menu.create(name: "Nasi Padang", price: 100.0, description: "Nasi padang enak", categories: [Category.create(name: "Main coruse")])
      ]
    }
    quantities {[2]}
  end
end
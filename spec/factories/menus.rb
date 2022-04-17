FactoryBot.define do
  factory :menu do
    name { Faker::Food.dish }
    description { "The best menu in this catering" }
    price { 10000.0 }
    categories {[Category.create(name: "Main coruse"), Category.create(name: "Starter")]}
  end

  factory :invalid_menu, parent: :menu do
    name { nil }
    description { "The best menu in this catering" }
    price { nil }
    categories {[]}
  end
end
require 'rails_helper'

RSpec.describe Menu, type: :model do
  it 'is valid with a name and a price' do
    menu = Menu.new(
      name: 'Nasi Uduk',
      price: 15000.0,
      description: "The best food ever"
    )

    expect(menu).to be_valid
  end

  it 'is invalid without a name' do
    menu = Menu.new(
      name: nil,
      price: 15000.0,
      description: "The best food ever"
    )

    menu.valid?

    expect(menu.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without a price' do
    menu = Menu.new(
      name: "Nasi Uduk",
      price: nil,
      description: "The best food ever"
    )
    
    menu.valid?

    expect(menu.errors[:price]).to include("can't be blank")
  end

  it 'is invalid with a duplicate name' do
    menu1 = Menu.create(
      name: "Nasi Uduk",
      price: 15000.0,
      description: "The best food ever"
    )

    menu2 = Menu.new(
      name: "Nasi Uduk",
      price: 15000.0,
      description: "The best food ever"
    )

    menu2.valid?

    expect(menu2.errors[:name]).to include("has already been taken")
  end

  it "is invalid with a non numeric values for price" do
    menu = Menu.new(
      name: "Nasi Uduk",
      description: "The best menu ever",
      price: "hello"
    )

    menu.valid?

    expect(menu.errors[:price]).to include("is not a number")
  end

  it 'is invalid with price less than 0.01' do
    menu = Menu.new(
      name: "Nasi Uduk",
      description: "Just with a different description",
      price: 0
    )

    menu.valid?

    expect(menu.errors[:price]).to include("must be greater than or equal to 0.01")
  end
end
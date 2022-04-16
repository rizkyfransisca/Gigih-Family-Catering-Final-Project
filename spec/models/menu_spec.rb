require 'rails_helper'

RSpec.describe Menu, type: :model do
  it 'is valid with a name and a price' do
    menu = Menu.new(
      name: 'Nasi Uduk',
      price: 15000.0
    )

    expect(menu).to be_valid
  end

  it 'is invalid without a name' do
    menu = Menu.new(
      name: nil,
      price: 15000.0
    )

    menu.valid?

    expect(menu.errors[:name]).to include("can't be blank")
  end
<<<<<<< HEAD

  it 'is invalid without a price' do
    menu = Menu.new(
      name: "Nasi Uduk",
      price: nil
    )
    
    menu.valid?

    expect(menu.errors[:price]).to include("can't be blank")
  end

  it 'is invalid with a duplicate name' do
    menu1 = Menu.create(
      name: "Nasi Uduk",
      price: 15000.0
    )

    menu2 = Menu.new(
      name: "Nasi Uduk",
      price: 15000.0
    )

    menu2.valid?

    expect(menu2.errors[:name]).to include("has already been taken")
  end
=======
>>>>>>> origin/main
end
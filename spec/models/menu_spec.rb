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
end
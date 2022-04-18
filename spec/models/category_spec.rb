require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'is valid with a name' do

    category = Category.create(
      name: "Main Course"
    )

    expect(category).to be_valid
  end

  it 'is invalid without a name' do
    category = Category.create(
      name: nil
    )

    category.valid?

    expect(category.errors[:name]).to include("can't be blank")
  end
end
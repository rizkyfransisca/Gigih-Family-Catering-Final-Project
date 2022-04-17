require 'rails_helper'

RSpec.describe Order, type: :model do
  it "is valid with a valid email format" do
    order = Order.create(
      customer_email:"rizky.royal@gmail.com", 
      total_price: 1500.0, 
      order_date: "01/01/2022", 
      status: "PAID"
    )

    order.valid?
    
    expect(order).to be_valid
  end

  it "is invalid with a invalid email format" do
    order = Order.create(
      customer_email:"halo@gigih", 
      total_price: 1500.0, 
      order_date: "01/01/2022", 
      status: "PAID"
    )

    order.valid?

    expect(order).not_to be_valid
  end

  # it "is invalid without categories" do
  #   order = Order.create(
  #     customer_email:"rizky.royal@gmail.com", 
  #     total_price: 1500.0, 
  #     order_date: "01/01/2022", 
  #     status: "PAID",
  #   )

  #   order.valid?

  #   print order.errors[:order_details]
    
  #   expect(order.errors[:menus]).to include("can't be blank")
  # end
end
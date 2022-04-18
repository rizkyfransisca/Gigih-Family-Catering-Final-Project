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

  describe 'self#get_todays_order' do
    it 'should return an array of results with a date corresponding to today' do
      nasi_uduk = Menu.create(
        name: "Nasi Uduk",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )

      todays_date = "18/04/2022"

      order1 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])

      order2 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: todays_date,
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])
      
      order3 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: todays_date,
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])

      expect(Order.get_todays_orders(todays_date)).to eq([order2, order3])
    end
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
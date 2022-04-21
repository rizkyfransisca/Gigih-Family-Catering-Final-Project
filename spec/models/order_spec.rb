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

  describe 'self#filter_by_customer_email' do
    it 'should return an array of results with the corresponding email' do
      nasi_uduk = Menu.create(
        name: "Nasi Uduk",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )

      customer_email = "rizky.royal@gmail.com"

      order1 = Order.create(
        customer_email: customer_email,
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])

      order2 = Order.create(
        customer_email: "rizky.baru@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])
      
      order3 = Order.create(
        customer_email: customer_email,
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])

      expect(Order.filter_by_customer_email(customer_email)).to eq([order1, order3])
    end
  end

  describe 'self#filter_by_equal_to_total_price' do
    it 'should return an array of results with the corresponding total price' do
      nasi_uduk = Menu.create(
        name: "Nasi Uduk",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )

      total_price = 15000.0

      order1 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])

      order2 = Order.create(
        customer_email: "rizky.baru@gmail.com",
        total_price: 15000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])
      
      order3 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])

      expect(Order.filter_by_equal_to_total_price(total_price)).to eq([order2])
    end
  end

  describe 'self#filter_by_date_range' do
    it 'should return an array of results with the corresponding date range' do
      nasi_uduk = Menu.create(
        name: "Nasi Uduk",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )

      start_date = "18/04/2022"
      end_date = "20/04/2022"

      order1 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "18/04/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])

      order2 = Order.create(
        customer_email: "rizky.baru@gmail.com",
        total_price: 15000.0,
        order_date: "20/04/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])
      
      order3 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])
      
      order4 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "19/04/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])

      expect(Order.filter_by_date_range(start_date, end_date)).to eq([order1, order2, order4])
    end
  end

  describe 'self#filter_by_greater_than_entered_total_price' do
    it 'should return an array of results with the total price greater than entered total price' do
      nasi_uduk = Menu.create(
        name: "Nasi Uduk",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )

      entered_total_price = 11000

      order1 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "18/04/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])

      order2 = Order.create(
        customer_email: "rizky.baru@gmail.com",
        total_price: 15000.0,
        order_date: "20/04/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])
      
      order3 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])
      
      order4 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 14000.0,
        order_date: "19/04/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])

      expect(Order.filter_by_greater_than_entered_total_price(entered_total_price)).to eq([order2, order4])
    end
  end

  describe 'self#filter_by_lower_than_entered_total_price' do
    it 'should return an array of results with the total price lower than entered total price' do
      nasi_uduk = Menu.create(
        name: "Nasi Uduk",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )

      entered_total_price = 11000

      order1 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "18/04/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])

      order2 = Order.create(
        customer_email: "rizky.baru@gmail.com",
        total_price: 15000.0,
        order_date: "20/04/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 3, menu_price: nasi_uduk.price)])
      
      order3 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 2, menu_price: nasi_uduk.price)])
      
      order4 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 15000.0,
        order_date: "19/04/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_uduk.id, quantity: 3, menu_price: nasi_uduk.price)])

      expect(Order.filter_by_lower_than_entered_total_price(entered_total_price)).to eq([order1, order3])
    end
  end
  
end
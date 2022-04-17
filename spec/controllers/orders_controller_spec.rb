require 'rails_helper'

RSpec.describe OrdersController do
  describe 'GET #index' do
    it 'populates an array of all orders' do
      menu = Menu.create(
        name: "Nasi Uduk",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )
      order1 = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price)])
      get :index
      expect(assigns(:orders)).to match_array([order1])
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'assigns the requested order to @order' do
      menu = Menu.create(
        name: "Nasi Uduk",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )
      order = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price)])
      
      get :show, params: {id: order}
      expect(assigns(:order)).to eq order
    end

    it 'renders the :show template' do
      menu = Menu.create(
        name: "Nasi Uduk",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )
      
      order = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price)])
      
      get :show, params: {id: order}
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new Order to @order' do
      get :new
      expect(assigns(:order)).to be_a_new(Order)
    end

    it 'populates an array of all menus' do
      nasi_uduk = Menu.create(
        name: "Nasi Uduk",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )
      nasi_kuning = Menu.create(
        name: "Nasi Kuning",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )
      
      get :new
      expect(assigns(:menus)).to match_array([nasi_uduk, nasi_kuning])
    end

    it 'renders the :new template' do
      get :new
      expect(:response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested Order to @order' do
      menu = Menu.create(
        name: "Nasi Uduk",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )
      
      order = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price)])
      
      get :show, params: {id: order}
      expect(assigns(:order)).to eq order
    end

    it 'populates an array of all menus from an order' do
      menu = create(:menu)
      menu1 = create(:menu)

      order = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price),OrderDetail.create(menu_id: menu1.id, quantity: 2, menu_price: menu1.price)])
      
      get :edit, params: {id: order}
      expect(assigns(:order_menus)).to match_array([menu, menu1])
    end

    it 'renders the :edit template' do
      menu = Menu.create(
        name: "Nasi Uduk",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )
      
      order = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price)])
      
      get :edit, params: { id: order }
      expect(response).to render_template :edit
    end
  end
  
  describe 'POST #create' do
    it "saves the new menu in the database" do
      expect{
        post :create, params: { order: attributes_for(:order) }
      }.to change(Order, :count).by(1)
    end
    it "redirects to orders#show" do
      post :create, params: { order: attributes_for(:order) }
      expect(response).to redirect_to(order_path(assigns[:order]))
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      menu = Menu.create(
        name: "Nasi Uduk",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )
      
      @order = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price)])
    end

    it "deletes the order from the database" do
      expect{
        delete :destroy, params: { id: @order }
      }.to change(Order, :count).by(-1)
    end

    it "redirects to orders#index" do
      delete :destroy, params: { id: @order }
      expect(response).to redirect_to orders_url
    end
  end
end
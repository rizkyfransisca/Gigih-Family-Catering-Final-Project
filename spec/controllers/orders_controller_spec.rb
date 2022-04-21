require 'rails_helper'

RSpec.describe OrdersController do
  describe 'GET #index' do
    context "without params" do
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

    context "with params[:customer_email]" do
      it 'populates an array of all orders with desired email' do
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
        
        order2 = Order.create(
          customer_email: "ratih@gmail.com",
          total_price: 10000.0,
          order_date: "01/01/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price)])

        order3 = Order.create(
          customer_email: "ratih@gmail.com",
          total_price: 10000.0,
          order_date: "01/01/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price)])
        get :index, params: { customer_email: 'ratih@gmail.com' }
        expect(assigns(:orders)).to match_array([order2, order3])
      end
  
      it 'renders the :index template' do
        get :index, params: { customer_email: 'ratih@gmail.com' }
        expect(response).to render_template :index
      end
    end

    context "with params[:total_price]" do
      it 'populates an array of all orders with the desired total price' do
        menu = Menu.create(
          name: "Nasi Uduk",
          price: 5000.0,
          categories: [Category.new(name: "Main Course")]
        )
        order1 = Order.create(
          customer_email: "rizky.royal@gmail.com",
          total_price: 15000.0,
          order_date: "01/01/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 3, menu_price: menu.price)])
        
        order2 = Order.create(
          customer_email: "ratih@gmail.com",
          total_price: 20000.0,
          order_date: "01/01/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 4, menu_price: menu.price)])

        order3 = Order.create(
          customer_email: "ratih@gmail.com",
          total_price: 15000.0,
          order_date: "01/01/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 3, menu_price: menu.price)])
        get :index, params: { total_price: 15000.0 }
        expect(assigns(:orders)).to match_array([order1, order3])
      end
  
      it 'renders the :index template' do
        get :index, params: { total_price: 15000.0 }
        expect(response).to render_template :index
      end
    end

    context "with params[:operator] == greater_than and params[:total_price]" do
      it 'populates an array of all orders with the total price greater params[:total_price] (entered total price)' do
        menu = Menu.create(
          name: "Nasi Uduk",
          price: 5000.0,
          categories: [Category.new(name: "Main Course")]
        )
        order1 = Order.create(
          customer_email: "rizky.royal@gmail.com",
          total_price: 15000.0,
          order_date: "18/04/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 3, menu_price: menu.price)])
        
        order2 = Order.create(
          customer_email: "ratih@gmail.com",
          total_price: 10000.0,
          order_date: "21/04/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price)])

        order3 = Order.create(
          customer_email: "ratih@gmail.com",
          total_price: 10000.0,
          order_date: "25/04/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price)])
        get :index, params: { operator: "greater_than",  total_price: 14000.0 }
        expect(assigns(:orders)).to match_array([order1])
      end
  
      it 'renders the :index template' do
        get :index, params: { operator: "greater_than",  total_price: 14000.0 }
        expect(response).to render_template :index
      end
    end

    context "with params[:operator] == lower_than and params[:total_price]" do
      it 'populates an array of all orders with the total price lower params[:total_price] (entered total price)' do
        menu = Menu.create(
          name: "Nasi Uduk",
          price: 5000.0,
          categories: [Category.new(name: "Main Course")]
        )
        order1 = Order.create(
          customer_email: "rizky.royal@gmail.com",
          total_price: 15000.0,
          order_date: "18/04/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 3, menu_price: menu.price)])
        
        order2 = Order.create(
          customer_email: "ratih@gmail.com",
          total_price: 10000.0,
          order_date: "21/04/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price)])

        order3 = Order.create(
          customer_email: "ratih@gmail.com",
          total_price: 10000.0,
          order_date: "25/04/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price)])
        get :index, params: { operator: "lower_than",  total_price: 14000.0 }
        expect(assigns(:orders)).to match_array([order2, order3])
      end
  
      it 'renders the :index template' do
        get :index, params: { operator: "lower_than",  total_price: 14000.0 }
        expect(response).to render_template :index
      end
    end

    context "with params[:start_date] and params[:end_date]" do
      it 'populates an array of all orders with the desired date range' do
        menu = Menu.create(
          name: "Nasi Uduk",
          price: 5000.0,
          categories: [Category.new(name: "Main Course")]
        )
        order1 = Order.create(
          customer_email: "rizky.royal@gmail.com",
          total_price: 15000.0,
          order_date: "18/04/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 3, menu_price: menu.price)])
        
        order2 = Order.create(
          customer_email: "ratih@gmail.com",
          total_price: 20000.0,
          order_date: "21/04/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 4, menu_price: menu.price)])

        order3 = Order.create(
          customer_email: "ratih@gmail.com",
          total_price: 15000.0,
          order_date: "25/04/2022",
          status: "NEW",
          order_details: [OrderDetail.create(menu_id: menu.id, quantity: 3, menu_price: menu.price)])
        get :index, params: { start_date: "20/04/2022",  end_date: "25/04/2022" }
        expect(assigns(:orders)).to match_array([order2, order3])
      end
  
      it 'renders the :index template' do
        get :index, params: { start_date: "20/04/2022",  end_date: "25/04/2022" }
        expect(response).to render_template :index
      end
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

    it 'populates an array of all menus' do
      menu = create(:menu, name: "Nasi Kuning")
      menu1 = create(:menu)

      order = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: menu.id, quantity: 2, menu_price: menu.price),OrderDetail.create(menu_id: menu1.id, quantity: 2, menu_price: menu1.price)])
      
      get :edit, params: {id: order}
      expect(assigns(:menus)).to match_array([menu, menu1])
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

  describe 'PATCH #update' do
    before :each do
      nasi_goreng = Menu.create(
        name: "Nasi Goreng",
        price: 5000.0,
        categories: [Category.new(name: "Main Course")]
      )
      
      @order = Order.create(
        customer_email: "rizky.royal@gmail.com",
        total_price: 10000.0,
        order_date: "01/01/2022",
        status: "NEW",
        order_details: [OrderDetail.create(menu_id: nasi_goreng.id, quantity: 2, menu_price: nasi_goreng.price)])
    end
    
    it "locates the requested @order" do
      patch :update, params: { id: @order, order: attributes_for(:order) }
      expect(assigns(:order)).to eq @order
    end

    it "changes @order's attributes" do
      new_menus = Menu.create(name: "Nasi Kuning", price: 1000.0, description: "Nasi kuning terbaik", categories: [Category.create(name: "Main course")])
      patch :update, params: {id: @order, order: attributes_for(:order, order_date: "2022-01-10", status: "PAID", customer_email: "sriratih@gmail.com", menus: [new_menus])}
      @order.reload
      expect([@order.order_date.to_s, @order.status, @order.customer_email, @order.menus]).to eq(["2022-01-10", "PAID","sriratih@gmail.com", [new_menus]])
    end

    it "redirects to the order" do
      patch :update, params: { id: @order, order: attributes_for(:order) }
      expect(response).to redirect_to @order
    end
  end
end
require 'date'
class OrdersController < ApplicationController
  before_action :set_menu, only: %i[ show edit update destroy ]
  protect_from_forgery
  
  def index
    # @orders = Order.includes([:order_details])
    @orders = Order.all
  end

  def show
  end

  def daily_report
    @orders = Order.get_todays_orders(params[:todays_date])
  end

  def edit
    @menus = Menu.all
  end

  def new
    @order = Order.new
    @menus = Menu.all
  end

  def create
    # di dalam form -> name="order["customer_email"]", "order["order_date"]", "order["status"]"
    customer_email = params.require(:order).permit(:customer_email)["customer_email"]
    order_date = params.require(:order).permit(:order_date)["order_date"]
    status = params.require(:order).permit(:status)["status"]
    # di dalam form -> name="order["menus"][]"
    order_menus_id = params.require(:order).permit(menus: [])["menus"]

    # di dalam form -> name="order["quantities"][]"
    menu_quantities = params.require(:order).permit(quantities: [])["quantities"]
    
    order_details = []
    total_price = 0
    menu_quantities.each_with_index do |quantity,index|
      order_details.append(OrderDetail.create(menu_id: order_menus_id[index], quantity: quantity, menu_price: Menu.find(order_menus_id[index]).price))
      total_price += order_details[index].menu_price * order_details[index].quantity
    end
    
    @order = Order.new(customer_email: customer_email, order_date: order_date, total_price: total_price, status: status, order_details: order_details)
    @order.save
    
    respond_to do |format|
      format.html { redirect_to order_path(@order), notice: "Order was successfully created." }
      format.json { render :show, status: :created, location: @order }
    end
  end

  def update
    # di dalam form -> name="order["customer_email"]", "order["order_date"]", "order["status"]"
    customer_email = params.require(:order).permit(:customer_email)["customer_email"]
    order_date = params.require(:order).permit(:order_date)["order_date"]
    status = params.require(:order).permit(:status)["status"]
    # di dalam form -> name="order["menus"][]"
    order_menus_id = params.require(:order).permit(menus: [])["menus"]

    # di dalam form -> name="order["quantities"][]"
    menu_quantities = params.require(:order).permit(quantities: [])["quantities"]
    
    order_details = []
    total_price = 0
    menu_quantities.each_with_index do |quantity,index|
      order_details.append(OrderDetail.create(menu_id: order_menus_id[index], quantity: quantity, menu_price: Menu.find(order_menus_id[index]).price))
      total_price += order_details[index].menu_price * order_details[index].quantity
    end
    
    @order.update(customer_email: customer_email, order_date: order_date, total_price: total_price, status: status, order_details: order_details)
    redirect_to order_path(@order)
  end

  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @order = Order.find(params[:id])
    end
end

class MenusController < ApplicationController
  before_action :set_menu, only: %i[ show edit update destroy ]
  protect_from_forgery
  
  def index
    @menus = Menu.includes([:categories])
  end

  def show
    # @menu = Menu.find(params[:id])
  end

  def new
    @menu = Menu.new
    @categories = Category.all
  end

  def edit
    # @menu = Menu.find(params[:id])
    @categories = Category.all
    @menu_categories = Menu.includes([:categories]).find(@menu.id)
  end

  def create
    # many to many create
    categories = []
    # di dalam form -> name="menu["categories"][]"
    categories_params = params.require(:menu).permit(categories: [])["categories"]
    # categories_params == nil -> categories nya kosong
    if categories_params == nil
      categories = []
    else
      categories_params.each do |category|
        categories.append(Category.find(category))
      end
    end

    # di dalam form -> name="menu["name"]", "menu["description"]", "menu["price"]"
    name = params.require(:menu).permit(:name)["name"]
    description = params.require(:menu).permit(:description)["description"]
    price = params.require(:menu).permit(:price)["price"]

    respond_to do |format|
      if name != "" && description != "" && price != "" && categories.length != 0
        @menu = Menu.new(name: name, description: description, price: price, categories: categories)
        @menu.save
        format.html { redirect_to menu_url(@menu), notice: "Menu was successfully created." }
        format.json { render :show, status: :created, location: @menu }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    categories = []
    # di dalam form -> name="menu["categories"][]"
    categories_params = params.require(:menu).permit(categories: [])["categories"]
    # categories_params == nil -> categories nya kosong
    if categories_params == nil
      categories = []
    else
      categories_params.each do |category|
        categories.append(Category.find(category))
      end
    end

    # di dalam form -> name="menu["name"]", "menu["description"]", "menu["price"]"
    name = params.require(:menu).permit(:name)["name"]
    description = params.require(:menu).permit(:description)["description"]
    price = params.require(:menu).permit(:price)["price"]
    @menu.update(name: name, description: description, price: price, categories: categories)
    redirect_to menu_path(@menu)
  end

  def destroy
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url, notice: "Menu was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_menu
      @menu = Menu.find(params[:id])
    end
end

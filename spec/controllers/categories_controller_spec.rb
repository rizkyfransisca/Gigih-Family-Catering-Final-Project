require 'rails_helper'

RSpec.describe CategoriesController do
  describe 'GET #index' do
    it "populates an array of all categories" do
      main_course = Category.create(name: "Main Course")
      dessert = Category.create(name: "Dessert")

      get :index
      expect(assigns(:categories)).to match_array([main_course, dessert])
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested category to @category" do
      category = Category.create(name: "Dessert")
      get :show, params: { id: category }
      expect(assigns(:category)).to eq category
    end
    it "renders the :show template" do
      category = Category.create(name: "Dessert")
      get :show, params: { id: category }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new Category to @category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
    it "renders the :new template" do
      get :new
      expect(:response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested category to @category" do
      category = Category.create(name: "Dessert")
      get :edit, params: { id: category }
      expect(assigns(:category)).to eq category
    end
    it "renders the :edit template" do
      category = Category.create(name: "Dessert")
      get :edit, params: { id: category }
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "saves the new category in the database" do
        expect{
          post :create, params: { category: {name: "Main Course"} }
        }.to change(Category, :count).by(1)
      end

      it "redirects to foods#show" do
        post :create, params: { category: {name: "Main Course"} }
        expect(response).to redirect_to(category_path(assigns[:category]))
      end
    end

    context "with invalid attributes" do
      it "does not save the new category in the database" do
        expect{
          post :create, params: {category: {name: nil} }
        }.not_to change(Category, :count)
      end
      it "re-renders the :new template" do
        post :create, params: { category: {name: nil} }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @category = Category.create(name: "Dessert")
    end
    
    context "with valid attributes" do
      it "locates the requested @category" do
        patch :update, params: { id: @category, category: {name: "Main Course"} }
        expect(assigns(:category)).to eq @category
      end
      
      it "changes @category's attributes" do
        patch :update, params: {id: @category, category: {name: "Appetaicer"}}
        @category.reload
        expect(@category.name).to eq("Appetaicer")
      end
      
      it "redirects to the category" do
        patch :update, params: { id: @category, category: {name: "Main Course"} }
        expect(response).to redirect_to @category
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @category = Category.create(name: "Dessert")
    end

    it "deletes the category from the database" do
      expect{
        delete :destroy, params: { id: @category }
      }.to change(Category, :count).by(-1)
    end

    it "redirects to foods#index" do
      delete :destroy, params: { id: @category }
      expect(response).to redirect_to categories_url
    end
  end
end
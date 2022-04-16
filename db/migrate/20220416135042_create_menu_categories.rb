class CreateMenuCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_categories do |t|
      t.string :menu_id
      t.string :category_id
      
      t.timestamps
    end
  end
end

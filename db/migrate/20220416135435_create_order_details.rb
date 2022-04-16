class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.string :menu_id
      t.string :order_id
      t.integer :quantity
      t.float :menu_price
      t.timestamps
    end
  end
end

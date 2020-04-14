class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
    	t.string :name
    	t.integer :price
    	t.integer :quantity
    	t.string :category
    end
  end
end

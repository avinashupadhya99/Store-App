class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
    	t.integer :quantity
    	t.bigint :amount
    	t.timestamps
    end
  end
end

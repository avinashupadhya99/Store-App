class AddReferencesToOrders < ActiveRecord::Migration[5.1]
  def change
  	add_reference :orders, :employee, foreign_key: true
  	add_reference :orders, :customer, foreign_key: true
  	add_reference :orders, :product, foreign_key: true
  end
end

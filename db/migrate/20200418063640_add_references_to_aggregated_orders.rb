class AddReferencesToAggregatedOrders < ActiveRecord::Migration[5.1]
  def change
  	add_reference :aggregated_orders, :employee, foreign_key: true
  	add_reference :aggregated_orders, :customer, foreign_key: true
  end
end

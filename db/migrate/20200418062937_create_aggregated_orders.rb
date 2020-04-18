class CreateAggregatedOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :aggregated_orders do |t|
    	t.timestamps
    end
  end
end

class RemoveTimestampsFromOrders < ActiveRecord::Migration[5.1]
  def change
  	remove_column :orders, :created_at
  	remove_column :orders, :updated_at
  end
end

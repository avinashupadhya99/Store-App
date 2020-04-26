class ChangeAmountToDecimalInOrders < ActiveRecord::Migration[5.1]
  def change
  	change_column :orders, :amount, :decimal
  end
end

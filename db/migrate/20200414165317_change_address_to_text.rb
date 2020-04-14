class ChangeAddressToText < ActiveRecord::Migration[5.1]
  def change
  	change_column :employees, :address, :text
  end
end

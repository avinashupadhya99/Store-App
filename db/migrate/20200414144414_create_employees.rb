class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
    	t.string :fName
    	t.string :lName
    	t.string :phone
    	t.string :email
    	t.date :dob
    	t.string :address
    	t.timestamps
    end
  end
end

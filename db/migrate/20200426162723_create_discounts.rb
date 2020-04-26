class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
    	t.datetime :starts_at
    	t.datetime :ends_at
    	t.decimal :percent
    end
  end
end

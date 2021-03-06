# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200426201825) do

  create_table "aggregated_orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.bigint "customer_id"
    t.index ["customer_id"], name: "index_aggregated_orders_on_customer_id"
    t.index ["employee_id"], name: "index_aggregated_orders_on_employee_id"
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "fname"
    t.string "lname"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.decimal "percent", precision: 10
    t.bigint "product_id"
    t.index ["product_id"], name: "index_discounts_on_product_id"
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "fName"
    t.string "lName"
    t.string "phone"
    t.string "email"
    t.date "dob"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "quantity"
    t.decimal "amount", precision: 10
    t.bigint "product_id"
    t.bigint "aggregated_order_id"
    t.index ["aggregated_order_id"], name: "index_orders_on_aggregated_order_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "price"
    t.integer "quantity"
    t.string "category"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.boolean "admin", default: false
    t.index ["employee_id"], name: "index_users_on_employee_id"
  end

  add_foreign_key "aggregated_orders", "customers"
  add_foreign_key "aggregated_orders", "employees"
  add_foreign_key "discounts", "products"
  add_foreign_key "orders", "aggregated_orders"
  add_foreign_key "orders", "products"
  add_foreign_key "users", "employees"
end

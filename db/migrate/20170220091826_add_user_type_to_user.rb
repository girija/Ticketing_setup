class AddUserTypeToUser < ActiveRecord::Migration
  def change
  	add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :user_type, :string, default: "customer"
  end
end

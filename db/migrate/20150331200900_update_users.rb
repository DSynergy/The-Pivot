class UpdateUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :credit_card, :string
    add_column :users, :billing_address, :string

  end
end

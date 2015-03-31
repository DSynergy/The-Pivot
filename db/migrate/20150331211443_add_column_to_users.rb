class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :integer
  end
end

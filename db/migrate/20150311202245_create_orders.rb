class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.integer :status, default: 0
      t.hstore :cart

      t.timestamps null: false
    end
  end
end

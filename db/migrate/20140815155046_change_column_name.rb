class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :orders, :room_id, :house_id
  end
end

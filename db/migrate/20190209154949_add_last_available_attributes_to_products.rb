class AddLastAvailableAttributesToProducts < ActiveRecord::Migration[5.2]
  def change
    change_table :products do |t|
      t.datetime :last_available
      t.datetime :last_unavailable
      t.datetime :p_created_at
    end
  end
end

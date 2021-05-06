class Add28gToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :p_v_28g, :boolean
  end
end

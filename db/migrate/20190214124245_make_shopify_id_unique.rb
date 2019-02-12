class MakeShopifyIdUnique < ActiveRecord::Migration[5.2]
  def change
    add_index :products, :p_id, unique: true
  end
end

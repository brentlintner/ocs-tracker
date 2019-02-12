class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.string :vendor, null: false
      t.string :handle, null: false
      t.string :plant, null: false
      t.boolean :available, null: false
      t.string :strain
      # TODO: index
      t.string :p_id, null: false
      t.boolean :p_v_default
      t.boolean :p_v_1g
      t.boolean :p_v_3_5g
      t.boolean :p_v_7g
      t.boolean :p_v_15g

      t.timestamps
    end
  end
end

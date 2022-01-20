class CreateFlowers < ActiveRecord::Migration[5.2]
  def change
    create_table :flowers do |t|
      t.string :flower_type, presence: true 
      t.integer :gardener_id
      t.integer :garden_id

      t.timestamps
    end
  end
end

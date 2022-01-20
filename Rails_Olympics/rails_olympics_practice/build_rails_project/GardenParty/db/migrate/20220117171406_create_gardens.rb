class CreateGardens < ActiveRecord::Migration[5.2]
  def change
    create_table :gardens do |t|
      t.string :name, presence: true, unique: {scope: :garden_owner_id}
      t.integer :size, presence: true
      t.integer :garden_owner_id

      t.timestamps
    end
  end
end

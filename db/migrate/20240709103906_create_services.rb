class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.string :name
      t.string :address
      t.text :description_menu
      t.boolean :available
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

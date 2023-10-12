class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :location
      t.decimal :price
      t.string :status

      t.timestamps
    end
  end
end

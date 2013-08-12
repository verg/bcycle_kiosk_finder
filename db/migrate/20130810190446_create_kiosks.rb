class CreateKiosks < ActiveRecord::Migration
  def change
    create_table :kiosks do |t|
      t.integer :external_id
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip_code
      t.float :latitude
      t.float :longitude
      t.string :status
      t.integer :docks_available
      t.integer :bikes_available

      t.timestamps
    end
    add_index :kiosks, :external_id
  end
end

class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, null: false
      t.integer :band_id, null: false
      t.string :recording_style, null: false

      t.timestamps null: false
    end
    add_index(:albums, [:band_id, :name], unique: true)
  end
end

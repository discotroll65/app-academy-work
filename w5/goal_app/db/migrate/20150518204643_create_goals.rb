class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.text :body, null: false
      t.integer :user_id, null: false
      t.boolean :public, null: false, default: false
      t.boolean :completed, null: false, default: false
      t.string :title, null: false

      t.timestamps null: false
    end

    add_index :goals, :user_id
    add_index :goals, :public
    add_index :goals, :completed
    add_index :goals, :updated_at
  end
end

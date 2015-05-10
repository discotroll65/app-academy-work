class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :article, index: true, foreign_key: true
      t.text :body
      t.string :author_name

      t.timestamps null: false
    end
  end
end

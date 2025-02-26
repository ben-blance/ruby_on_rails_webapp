# db/migrate/XXXXXX_create_stores.rb (edit the existing file)
class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :email
      t.text :address
      t.references :owner, foreign_key: { to_table: :users }, null: true

      t.timestamps
    end
    add_index :stores, :email, unique: true
  end
end

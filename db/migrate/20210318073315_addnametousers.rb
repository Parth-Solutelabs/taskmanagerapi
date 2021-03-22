class Addnametousers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :contact, :string
    add_reference :users, :organization, null: false, foreign_key: true
    add_column :users, :activate, :boolean, default: false
  end
end

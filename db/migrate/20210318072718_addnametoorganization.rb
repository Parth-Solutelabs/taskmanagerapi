class Addnametoorganization < ActiveRecord::Migration[6.1]
  def change
    add_column :organizations, :name, :string
    add_column :organizations, :contact, :int
  end
end

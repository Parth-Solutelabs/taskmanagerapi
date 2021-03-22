class Change < ActiveRecord::Migration[6.1]
  def change
    remove_column :organizations, :contact, :string
    add_column :organizations, :contact, :string

  end
end

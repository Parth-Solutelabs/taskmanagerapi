class Addinvite < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :invite_digest, :string
  end
end

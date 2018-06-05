class AddAuthToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :integer
    add_column :users, :oath_token, :string
    add_column :users, :oath_expires_at, :datetime
  end
end

class AddPrivateToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :privat, :string
  end
end

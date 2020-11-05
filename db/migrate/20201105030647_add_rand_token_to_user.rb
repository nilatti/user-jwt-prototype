class AddRandTokenToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :rand_token, :string, null: true
  end
end

class AddActivatedActivationTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :activated, :boolean, default: false
    add_column :users, :activation_token, :string, null: false
  end
end

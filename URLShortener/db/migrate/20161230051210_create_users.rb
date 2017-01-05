class CreateUsers < ActiveRecord::Migration[5.0]
  def up
    premium :boolean, :default => true
  end
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.boolean :premium
      t.timestamps
    end
  end
end

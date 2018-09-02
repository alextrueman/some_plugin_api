class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :browser_name
      t.string :auth_token

      t.timestamps
    end
  end
end

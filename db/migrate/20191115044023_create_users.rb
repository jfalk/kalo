class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.boolean :global_admin, null: false
      t.string :timezone
      t.boolean :receive_marketing, null: false
      t.string :external_id

      t.timestamps
    end

    add_index :users, :external_id
    add_index :users, :global_admin
    add_index :users, :receive_marketing
  end
end

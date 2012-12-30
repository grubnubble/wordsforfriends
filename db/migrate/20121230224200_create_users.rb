class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :pass
      t.string :email
      t.boolean :active

      t.timestamps
    end
  end
end

class CreateWritings < ActiveRecord::Migration
  def change
    create_table :writings do |t|
      t.string :title
      t.text :body
      t.boolean :global_r
      t.boolean :friends_r
      t.integer :author_id

      t.timestamps
    end
  end
end

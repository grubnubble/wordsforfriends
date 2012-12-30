class CreateWritingTagJoins < ActiveRecord::Migration
  def change
    create_table :writing_tag_joins do |t|
      t.integer :tag_id
      t.integer :writing_id

      t.timestamps
    end
  end
end

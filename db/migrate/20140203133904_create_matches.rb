class CreateMatches < ActiveRecord::Migration
 def up
    create_table :matches do |t|
      t.string  :name
      t.integer :year
      t.float   :distance
      t.integer :participant_id
      t.timestamps
    end
    add_index :matches, :participant_id
  end

  def down
    drop_table   :matches
    remove_index :matches, :participant_id
  end
end

class CreateCategories < ActiveRecord::Migration
  def up
    create_table  :categories do |t|
      t.string    :description
      t.integer   :activity_id
      t.float     :distance
      t.integer   :age_from
      t.integer   :age_to
      t.string    :gender
      t.integer   :start_startnumber
      t.date      :start_time
      t.timestamp
    end
    add_index :categories, :activity_id
  end

  def down
    drop_table   :categories
    remove_index :categories, :activity_id
  end
end

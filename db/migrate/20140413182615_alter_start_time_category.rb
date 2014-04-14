class AlterStartTimeCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :start_time
    add_column :categories, :start_time, :datetime
  end
end

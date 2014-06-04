class DeleteStartStartnumberOfCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :start_startnumber
  end
end

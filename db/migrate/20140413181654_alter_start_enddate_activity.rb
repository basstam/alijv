class AlterStartEnddateActivity < ActiveRecord::Migration
  def change
    remove_column :activities, :start_date
    remove_column :activities, :end_date

    add_column :activities, :start_date, :datetime
    add_column :activities, :end_date, :datetime
  end
end

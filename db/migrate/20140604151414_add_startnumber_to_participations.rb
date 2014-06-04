class AddStartnumberToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :startnumber, :integer
  end
end

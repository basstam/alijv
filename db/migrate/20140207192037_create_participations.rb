class CreateParticipations < ActiveRecord::Migration
  def up
    create_table :participations do |t|
      t.integer   :participant_id
      t.integer   :activity_id
      t.integer   :categorie_id
      t.date      :end_time
      t.date      :total_time
      t.integer   :ranking
      t.timestamp
    end
    add_index :participations, :participant_id
    add_index :participations, :activity_id
    add_index :participations, :categorie_id
  end

  def down
    drop_table :participations
    remove_index :participations, :participant_id
    remove_index :participations, :activity_id
    remove_index :participations, :categorie_id
  end
end

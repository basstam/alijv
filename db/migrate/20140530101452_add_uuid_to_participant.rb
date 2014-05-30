class AddUuidToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :uuid, :string, :null => false
    add_index :participants, :uuid
  end
end

class DropMatchesTable < ActiveRecord::Migration
  def up
    drop_table :matches
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

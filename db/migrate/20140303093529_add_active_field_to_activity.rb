class AddActiveFieldToActivity < ActiveRecord::Migration
  def up
    add_column :activities, :active, :boolean, :default => false
  end

  def down
    remove_column :activities, :active
  end
end

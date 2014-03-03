class AddActiveFieldToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :active, :boolean, :default => false
  end
end

class AddStreetNumber < ActiveRecord::Migration
  def up
  	add_column :participants, :street_number, :string
  	rename_column :participants, :address, :street
  end

  def down
  	remove_column :participants, :street_number
  	rename_column :participants, :street, :address
  end
end


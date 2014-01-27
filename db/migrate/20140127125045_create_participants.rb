class CreateParticipants < ActiveRecord::Migration
  def up
    create_table :participants do |t|
      t.string :firstname
      t.string :lastname
      t.string :address
      t.string :zipcode
      t.string :city
      t.string :email
      t.string :phone
      t.date :date_of_birth
      t.string :gender

      t.timestamps
    end
  end

  def down
    drop_table :participants
  end
end

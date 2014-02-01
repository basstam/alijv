class Participant < ActiveRecord::Base

  validates_presence_of :firstname, :lastname, :street, :street_number, :zipcode, :city, :email, :phone, :date_of_birth, :gender 

end

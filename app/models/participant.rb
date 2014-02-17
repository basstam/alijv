class Participant < ActiveRecord::Base

  validates_presence_of :firstname, :lastname, :street, :street_number, :zipcode, :city, :email, :phone, :date_of_birth, :gender 

  validates_format_of :email, :with => /\A([^@\s]{1}+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :allow_blank=>true

  validates :gender, :inclusion => {:in => ['F', 'M']}

  validates :zipcode, format: /\A[0-9]{4}[A-Z]{2}\z/

  validates :phone, format: /\A[0-9]{10}\z/

end

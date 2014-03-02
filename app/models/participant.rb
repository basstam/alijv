class Participant < ActiveRecord::Base

  has_many :participations, dependent: :destroy

  accepts_nested_attributes_for :participations

  validates :firstname, :lastname, :street, :street_number, :zipcode, :city, :email, :phone, :date_of_birth, :gender, presence: true

  validates :email, format: /\A([^@\s]{1}+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, allow_blank: true

  validates :gender, inclusion: {in: ['V', 'M']}

  validates :zipcode, format: /\A[0-9]{4}[A-Z]{2}\z/

  validates :phone, format: /\A[0-9]{10}\z/

end

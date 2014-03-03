class Participant < ActiveRecord::Base

  attr_writer :distance, :activity_id

  has_many :participations, dependent: :destroy

  validates :firstname, :lastname, :street, :street_number, :zipcode, :city, :email, :phone, :date_of_birth, :gender, presence: true

  validates :email, format: /\A([^@\s]{1}+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, allow_blank: true

  validates :gender, inclusion: {in: ['F', 'M']}

  validates :zipcode, format: /\A[0-9]{4}[A-Z]{2}\z/

  validates :phone, format: /\A[0-9]{10}\z/

  before_create :prevent_double_participant

  private

  def prevent_double_participant
    participant = Participant.where(firstname: firstname, lastname: lastname, date_of_birth: date_of_birth).first
    participant.present? ? false : true
  end

end

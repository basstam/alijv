class Participant < ActiveRecord::Base

  attr_accessor :activity_id, :distance

  has_many :participations, dependent: :destroy

  validates :firstname, :lastname, :street, :street_number, :zipcode, :city, :email, :phone, :date_of_birth, :gender, :distance, presence: true

  validates :email, format: /\A([^@\s]{1}+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, allow_blank: true

  validates :gender, inclusion: {in: ['F', 'M']}

  validates :zipcode, format: /\A[0-9]{4}[A-Z]{2}\z/

  validates :phone, format: /\A[0-9]{10}\z/

  def attributes
    super.merge('distance' => self.distance, 'activity_id' => self.activity_id)
  end

  private

  def prevent_double_participant
    participant = Participant.where(firstname: firstname, lastname: lastname, date_of_birth: date_of_birth).first
    participant.present? ? false : true
  end

end

class Participant < ActiveRecord::Base

  attr_accessor :activity_id, :distance

  has_many :participations, dependent: :destroy

  validates :firstname, :lastname, :street, :street_number, :zipcode, :city, :email, :phone, :date_of_birth, :gender, :distance, presence: true

  validates :email, format: /\A([^@\s]{1}+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, allow_blank: true

  validates :gender, inclusion: {in: ['F', 'M']}

  validates :zipcode, format: /\A[0-9]{4}[A-Z]{2}\z/

  validates :phone, format: /\A[0-9]{10}\z/

  after_save  :create_partipation_if_valid
  before_create :prevent_double_participant

  def attributes
    super.merge('distance' => self.distance, 'activity_id' => self.activity_id)
  end

  def distance
    p Activity.active
    participation = participations.where(activity_id: Activity.active.id).first
    participation.present? ? participation.distance : @distance
  end

  private

  def prevent_double_participant
    participant = Participant.where(firstname: firstname, lastname: lastname, date_of_birth: date_of_birth).first
    participant.present? ? false : true
  end

  def create_partipation_if_valid
    if @distance.present? && @activity_id.present?
      category = Category.find_matching(date_of_birth: self.date_of_birth, gender: self.gender, distance: @distance, activity_id: @activity_id)
      if category.present?
        Participation.create!(participant_id: self.id, category_id: category.id, activity_id: @activity_id)
      else
        self.errors[:base] = 'Geen bijbehorende categorie gevonden!'
        raise ActiveRecord::Rollback
      end
    end
  end

end

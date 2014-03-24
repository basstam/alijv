class Participant < ActiveRecord::Base

  attr_accessor :activity_id, :distance

  has_many :participations, dependent: :destroy

  validates :firstname, :lastname, :street, :street_number, :zipcode, :city, :email, :phone, :date_of_birth, :gender, :distance, presence: true

  validates :email, format: /\A([^@\s]{1}+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, allow_blank: true

  validates :gender, inclusion: {in: ['F', 'M']}

  validates :zipcode, format: /\A[0-9]{4}[A-Z]{2}\z/

  validates :phone, format: /\A[0-9]{10}\z/

  after_save    :assign_participation_if_valid
  before_create :prevent_double_participant

  def attributes
    super.merge('distance' => self.distance, 'activity_id' => self.activity_id)
  end

  def distance
    current_participation.present? ? current_participation.distance : @distance
  end

  private

  def current_participation
    participations.where(activity_id: Activity.active.id).first
  end

  def current_category
    Category.find_matching(date_of_birth: self.date_of_birth, gender: self.gender, distance: @distance, activity_id: @activity_id)
  end

  def prevent_double_participant
    participant = Participant.where(firstname: firstname, lastname: lastname, date_of_birth: date_of_birth).first
    participant.present? ? false : true
  end

  def participation_fields_present?
    @distance.present? && @activity_id.present?
  end

  def assign_participation_if_valid
    if participation_fields_present?
      if current_category.present?
        create_or_update_participation
      else
        self.errors[:base] = 'Geen bijbehorende categorie gevonden!'
        raise ActiveRecord::Rollback
      end
    end
  end

  def create_or_update_participation
    if current_participation.present?
      current_participation.update_attribute(:category_id, current_category.id)
    else
      Participation.create!(participant_id: self.id, category_id: current_category.id, activity_id: @activity_id)
    end
  end

end

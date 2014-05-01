class Participant < ActiveRecord::Base

  attr_accessor :activity_id, :distance

  has_many   :participations, dependent: :destroy

  validates  :firstname, :lastname, :street, :street_number, :zipcode, :city, :email, :phone, :date_of_birth, :gender, :distance, presence: true

  validates  :email, format: /\A([^@\s]{1}+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, allow_blank: true

  validates  :gender, inclusion: {in: ['F', 'M']}

  validates  :zipcode, format: /\A[0-9]{4}[A-Z]{2}\z/

  validates  :phone, format: /\A[0-9]{10}\z/

  after_save  :assign_participation_if_valid

  auto_strip_attributes :zipcode, :delete_whitespaces => true

  def attributes
    super.merge('distance' => distance, 'activity_id' => activity_id)
  end

  def distance
    active_participation.present? ? active_participation.distance : @distance
  end

  def store
    participant = Participant.where(firstname: firstname, lastname: lastname, date_of_birth: date_of_birth).first
    if participant.present?
      @existing_participant = participant
      assign_participation_if_valid
      true
    else
      save
    end
  end

  private

  def current_id
    self.id || (@existing_participant.present? && @existing_participant.id)
  end

  def active_participation
    participations.where(activity_id: Activity.active.id).first
  end

  def associated_participation
    Participation.where(activity_id: activity_id, participant_id: current_id).first if current_id
  end

  def associated_category
    Category.find_matching(date_of_birth: date_of_birth.to_s, gender: gender, distance: distance, activity_id: activity_id)
  end

  def participation_fields_present?
    distance.present? && activity_id.present?
  end

  def assign_participation_if_valid
    if participation_fields_present?
      if associated_category.present?
        create_or_update_participation
      else
        self.errors[:base] = 'Geen bijbehorende categorie gevonden!'
        raise ActiveRecord::Rollback
      end
    end
  end

  def create_or_update_participation
    if associated_participation.present?
      associated_participation.update_attribute(:category_id, associated_category.id)
    else
      Participation.create!(participant_id: current_id, category_id: associated_category.id, activity_id: activity_id)
    end
  end

end

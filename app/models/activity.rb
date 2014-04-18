class Activity < ActiveRecord::Base

  has_many :categories, dependent: :destroy

  validates :name, :description, :start_date, presence: true

  validate :start_date_before_end_date?

  after_save :validate_maximum_active_activities

  scope :active, -> { where(active: true).first }


  def start_date_before_end_date?
    if end_date.present? && start_date > end_date
      self.errors.add(:start_date, 'moet kleiner of gelijk zijn dan de einddatum')
    end
  end

  def validate_maximum_active_activities
    if Activity.where(active: true).count > 1
      self.errors[:base] = 'Er mag maximaal 1 activiteit actief zijn.'
      raise ActiveRecord::Rollback
    end
  end
end

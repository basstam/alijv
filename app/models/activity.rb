class Activity < ActiveRecord::Base

  has_many :categories, dependent: :destroy

  validates :name, :description, :start_date, presence: true

  validate :start_date_before_end_date?

  before_save :category_starttime_in_range_start_enddate?

  after_save :validate_maximum_active_activities

  scope :active, -> { where(active: true).first }

  def category_starttime_in_range_start_enddate?
    if categories.where("start_time is not null").where('start_time > ?', self.end_date).count > 0
      self.errors.add(:base, 'De starttijd(en) van de bijbehorende categorie(en) moet(en) binnen de start en einddatum van de activiteit liggen')
    end
  end

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

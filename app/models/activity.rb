class Activity < ActiveRecord::Base

  has_many :categories, dependent: :destroy

  validates :name, :description, presence: true

  after_save :validate_maximum_active_activities

  scope :active, -> { where(active: true).first }

  def validate_maximum_active_activities
    if Activity.where(active: true).count > 1
       self.errors[:base] = 'Er mag maximaal 1 activiteit actief zijn.'
       raise ActiveRecord::Rollback
    end
  end
end

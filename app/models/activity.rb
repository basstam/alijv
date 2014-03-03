class Activity < ActiveRecord::Base

  has_many :categories, dependent: :destroy

  validates :name, :description, presence: true

  scope :all_active, -> { where(active: true) }

end

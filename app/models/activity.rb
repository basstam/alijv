class Activity < ActiveRecord::Base

  has_many :categories, dependent: :destroy

  validates :name, :description, presence: true

  scope :active, -> { where(active: true).first }

end

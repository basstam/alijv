class Category < ActiveRecord::Base
  belongs_to  :activity
  has_many    :participations, dependent: :destroy

  validates   :description, :activity_id, :distance, :age_from, :gender, presence: true

  validates :gender, inclusion: {in: ['V', 'M']}

end
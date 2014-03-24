class Participation < ActiveRecord::Base
  belongs_to :activity
  belongs_to :category
  belongs_to :participant

  validates :activity_id, :participant_id, :category_id,  presence: true

  delegate :distance, to: :category
end

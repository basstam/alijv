class Participation < ActiveRecord::Base
  belongs_to :activity
  belongs_to :category
  belongs_to :participant

  validates :activity, :participant, :category,  presence: true
end

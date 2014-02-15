class Participation < ActiveRecord::Base
  belongs_to :activity
  belongs_to :category
  belongs_to :participant 

  validates_presence_of :activity_id, :category_id, :participant_id
end

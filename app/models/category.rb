class Category < ActiveRecord::Base
  belongs_to  :activity
  has_many   :participations, :dependent => :destroy

  validates_presence_of :description, :activity_id, :distance, :age_from, :gender

end
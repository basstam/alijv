class Participation < ActiveRecord::Base
  belongs_to  :activity
  belongs_to  :category
  belongs_to  :participant

  validates   :activity_id, :participant_id, :category_id,  presence: true

  before_update :update_allowed? 

  delegate :distance, to: :category

  def update_allowed?
    activity = Activity.find(self.activity_id)
    if activity.end_date.present?  && activity.end_date < Time.now.utc.to_date
      self.errors.add(:base, 'Deelname kan niet meer worden bijgewerkt, activiteit is afgesloten')
    end
  end
end

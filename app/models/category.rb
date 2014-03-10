class Category < ActiveRecord::Base
  belongs_to  :activity
  has_many    :participations, dependent: :destroy

  validates   :description, :activity_id, :distance, :age_from, :gender, presence: true

  validates :gender, inclusion: {in: ['F', 'M']}

  def self.find_matching(options)
    date_of_birth = options[:date_of_birth]
    if date_of_birth
      age = age(date_of_birth)
      Category.where(options.slice(:distance, :activity_id, :gender)).where(['? >= age_from AND ? < age_to', age, age]).first
    end
  end

  private

  def self.age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

end
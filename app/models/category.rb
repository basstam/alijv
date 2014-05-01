class Category < ActiveRecord::Base
  belongs_to  :activity
  has_many    :participations, dependent: :destroy

  validates   :description, :activity_id, :distance, :age_from, :gender, presence: true

  validates   :gender, inclusion: {in: ['F', 'M']}

  before_save :starttime_in_range_activity_start_enddate?

  def self.find_matching(options)
    date_of_birth = Date.parse(options[:date_of_birth]) if options[:date_of_birth].present?
    if date_of_birth
      age = age(date_of_birth)
      Category.where(options.slice(:distance, :activity_id, :gender)).where(['? >= age_from AND ? < age_to', age, age]).first
    end
  end

  def starttime_in_range_activity_start_enddate?
    if    self.start_time.present? && 
       ( Activity.where("end_date is not null").where("end_date <= ?", self.start_time).present? ||
        Activity.where("start_date > ?", self.start_time).present? )
          
      self.errors.add(:base, 'De starttijd moet binnen de start en einddatum van de activiteit liggen')
    end
  end


  private

  def self.age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

end
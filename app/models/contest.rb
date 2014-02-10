class Contest < ActiveRecord::Base
  has_many :solutions, dependent: :destroy
  has_and_belongs_to_many :puzzles
  has_and_belongs_to_many :hackers

  validates :name, presence: true

  def started
    (self.start_time == nil) or (DateTime.now >= self.start_time)
  end

  def ended
    (self.end_time != nil) and (DateTime.now > self.end_time)
  end
end

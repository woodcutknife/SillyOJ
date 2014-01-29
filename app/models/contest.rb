class Contest < ActiveRecord::Base
  has_many :solutions, dependent: :destroy
  has_and_belongs_to_many :puzzles
  has_and_belongs_to_many :hackers

  validates :name, presence: true

  after_create :set_time

  protected

  def set_time
    if start_time
      snds = start_time.to_i - Time.now.to_i
      self.delay(run_at: snds.from_now).set_start
    end
    if end_time
      snds = end_time.to_i - Time.now.to_i
      self.delay(run_at: snds.from_now).set_end
    end
  end

  def set_start
    self.started = true
    self.save
  end

  def set_end
    self.ended = true
    self.save
  end
end

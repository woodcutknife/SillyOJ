class Hacker < ActiveRecord::Base
  has_many :solutions, dependent: :destroy
  has_and_belongs_to_many :contests
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable

  validates :name, presence: true,
                   length: { minimum: 1, maximum: 20 },
                   format: { with: /\A[a-z0-9_-]+\Z/ }

  before_create :practice

  protected

  def practice
    Contest.where(default: true).each do |c|
      self.contests << c
    end
  end
end

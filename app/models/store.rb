class Store < ActiveRecord::Base
  belongs_to :user
  validates :registrationNumber, uniqueness: true
  validates :shopName, presence: true
  validates :locality, presence: true
  validates :city, presence: true
  validates :pin, presence: true
end

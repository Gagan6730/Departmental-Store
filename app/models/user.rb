class User < ActiveRecord::Base
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true
  validates :email, uniqueness: true
  validates :firstName, presence: true
  validates :lastName, presence: true
  has_one :store
end

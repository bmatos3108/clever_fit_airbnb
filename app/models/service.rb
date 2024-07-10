class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings
  # has_many :reviews, dependent: :destroy
  has_many_attached :images
end

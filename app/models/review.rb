class Review < ApplicationRecord
  belongs_to :booking
  has_one :service, through: :booking
  # belongs_to :service, through: :booking
  validates :rating, presence: true
  validates :comment, presence: true
  # def service
  #   booking.service
  # end
end

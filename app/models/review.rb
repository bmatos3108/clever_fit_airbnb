class Review < ApplicationRecord
  belongs_to :booking
  # belongs_to :service, through: :booking
  belongs_to :user
  validates :rating, presence: true
  validates :comment, presence: true
  def service
    booking.service
  end
end

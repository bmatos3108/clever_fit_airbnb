class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  has_many_attached :images
  include PgSearch::Model
  pg_search_scope :search_by_name_and_address,
  against: [ :name, :address ],
  using: {
    tsearch: { prefix: true }
  }
end

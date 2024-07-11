class Service < ApplicationRecord
  # Associations
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

  # Validations
  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0} # Makes sure it can't be a negative number
end

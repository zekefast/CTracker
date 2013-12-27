class CountriesCurrency < ActiveRecord::Base
  belongs_to :country
  belongs_to :currency
  has_many :collections
  has_many :users,
    through: :collections

  validates :country,
    presence: true
  validates :currency,
    presence: true
end

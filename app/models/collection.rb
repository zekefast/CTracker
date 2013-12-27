class Collection < ActiveRecord::Base
  belongs_to :countries_currency
  belongs_to :user
  has_one :country,
    through: :countries_currency
  has_one :currency,
    through: :countries_currency

  validates :countries_currency,
    presence: true
  validates :user,
    presence: true
end

class Currency < ActiveRecord::Base
  has_one :countries_currency
  has_many :countries,
    through: :countries_currency

  validates :name,
    presence: true
  validates :code,
    presence: true,
    uniqueness: true
end

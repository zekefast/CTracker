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


  class << self
    # @return [Hash{String=>Integer}] number of collections indexed by dates
    def count_by_date
      group("DATE(created_at)").
      count
    end
  end
end

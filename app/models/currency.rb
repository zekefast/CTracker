class Currency < ActiveRecord::Base
  self.primary_key = :code
  #attr_accessible :name, :code, :country_id

  validates :name,
    presence: true
  validates :code,
    presence: true,
    uniqueness: {allow_blank: true}


  belongs_to :country

  def self.collected
    all.select {|currency| currency.collected? }
  end

  def self.not_collected
    all.reject {|currency| currency.collected? }
  end

  def collected?
    country.nil? ? false : country.visited?
  end
end

class Currency < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true
  validates_presence_of :country

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

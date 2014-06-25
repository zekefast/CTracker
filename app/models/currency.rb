class Currency < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true
  validates_presence_of :country

  belongs_to :country
  has_many :collection_items
end

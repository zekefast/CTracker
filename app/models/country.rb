class Country < ActiveRecord::Base
  self.primary_key = :code

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true

  has_many :currencies

  accepts_nested_attributes_for :currencies, :allow_destroy => true

  scope :visited,     ->() { where(visited: true)  }
  scope :not_visited, ->() { where(visited: false) }
end

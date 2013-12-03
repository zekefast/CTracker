class Country < ActiveRecord::Base
  self.primary_key = :code

  validates :name,
    presence: true
  validates :code,
    presence: true,
    uniqueness: {allow_blank: true}


  has_many :currencies

  accepts_nested_attributes_for :currencies, :allow_destroy => true


  scope :visited, lambda {
    where(visited: true)
  }
  scope :not_visited, lambda {
    where(visited: false)
  }
end

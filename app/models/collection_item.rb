class CollectionItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :currency
  has_one :country,
    :through => :currency

  validates :user,
    presence: true
  validates :currency,
    presence: true
end

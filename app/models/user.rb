class User < ActiveRecord::Base
  has_many :collection_items
  has_many :currencies,
    :through => :collection_items
  has_many :countries,
    :through => :collection_items

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :recoverable,
  # :rememberable, :trackable
  devise :database_authenticatable, :registerable, :validatable


  # @param country [Country]
  #
  # @return [Boolean]
  def visited?(country)
    countries.include?(country)
  end

  # @param currency [Currency]
  #
  # @return [Boolean]
  def collected?(currency)
    currencies.include?(currency)
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable,
  # :recoverable, :trackable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :collections
  has_many :countries_currencies,
    through: :collections

  # @param country_currency [CountriesCurrency]
  #
  # @return [Boolean] true when user owned given country_currency combination,
  #   otherwise - false
  def owned?(country_currency)
    self.countries_currencies.include?(country_currency)
  end
end

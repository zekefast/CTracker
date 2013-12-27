class ::Ct::CountriesCurrenciesSeeder
  attr_accessor :service


  # @param service [] service instance
  def initialize(service)
    @service = service
  end

  # @return [void]
  def call
    @service.currencies do |*data|
      print(*data)
      store(*data)
    end
  end

  # @return [void]
  def print(country_name, country_code, currency_name, currency_code)
    puts "Country:  #{country_name}(#{country_code})"
    puts "Currency: #{currency_name}(#{currency_code})"
    puts
  end

  # @return [void]
  def store(country_name, country_code, currency_name, currency_code)
    country_is_ok  = !(country_name.blank? || country_code.blank?)
    currency_is_ok = !(currency_name.blank? || currency_code.blank?)

    ActiveRecord::Base.transaction do
      country              = ::Country.find_or_create_by_code!(name: country_name, code: country_code) if country_is_ok
      currency             = ::Currency.find_or_create_by_code!(name: currency_name, code: currency_code) if currency_is_ok
      countries_currencies = ::CountriesCurrency.find_or_create_by!(country: country, currency: currency) if country && currency
    end
  end
end

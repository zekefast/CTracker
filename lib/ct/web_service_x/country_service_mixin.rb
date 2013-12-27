require "nokogiri"


# Module to include into CountryService classes to share common code between
# those classes.
#
# Class which include service should implement follow methods:
# - #get_currencies
#
# @example
#
#   class ::Ct::WebServiceX::AdvancedCountryService
#     include ::Ct::WebServiceX::CountryService
#
#     def get_currencies
#       # real implementation of data retriving from service goes here
#     end
#   end
module ::Ct::WebServiceX::CountryServiceMixin
  # Parse service response to list of hashes with countries and currencies data
  # accordingly.
  #
  # @param country_name_key  [void] (:country_name)
  # @param country_code_key  [void] (:country_code)
  # @param currency_name_key [void] (:currency_name)
  # @param currency_code_key [void] (:currency_code)
  #
  # @yield block to process single table returned from service
  # @yieldparam country_name  [String] name of the country
  # @yieldparam country_code  [String] two letter country code
  # @yieldparam currency_name [String] name of the currency
  # @yieldparam currency_code [String] three letter currency code
  # @yieldreturn object to build list with, by default it's hash with data
  #   given to block and proper names of keys
  #
  # @return [Array<Hash, void>]
  # @example
  #
  #   countries_currencies = country_service.currencies # with default names of hash keys
  #   first_country_code   = countries_currencies.first[:country_code]
  #
  #   # or
  #
  #   countries_currencies = country_service.currencies(:CountryName, :CountryCode, :CurrencyName, :CurrencyCode)
  #   first_country_code   = countries_currencies.first[:CountryCode]
  #
  #   # or
  #
  #   Country  = Struct.new(:name, :code)
  #   Currency = Struct.new(:name, :code)
  #   countries_currencies = country_service.currencies do |country_name, country_code, currency_name, currency_code|
  #     {Country.new(country_name, country_code) => Currency.new(currency_name, currency_code)}
  #   end
  #   country, currency = countries_currencies.first
  #   first_country_name = country.name
  #   first_country_code = country.code
  def currencies(country_name_key = :country_name, country_code_key = :country_code, currency_name_key = :currency_name, currency_code_key = :currency_code)
    node_handler = if block_given?
      ->(table) do
        yield table.css("Name").text, table.css("CountryCode").text, table.css("Currency").text, table.css("CurrencyCode").text
      end
    else
      ->(table) do
        {
          country_name_key  => table.css("Name").text,
          country_code_key  => table.css("CountryCode").text,
          currency_name_key => table.css("Currency").text,
          currency_code_key => table.css("CurrencyCode").text
        }
      end
    end

    ::Nokogiri::XML::Document.parse(get_currencies).css("Table").map(&node_handler)
  end
end

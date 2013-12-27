# Used in development mode, as the web service is not reliable.
class ::Ct::WebServiceX::DummyLocalFileCountryService
  include ::Ct::WebServiceX::CountryServiceMixin


  FILE_NAME                           = "get_currencies.xml".freeze
  COUNTRIES_CURRENCIES_LIST_FILE_PATH = File.join(__dir__, "dummy_service_data", "country", FILE_NAME).freeze

  # @!attribute data_source_file
  #   @return [String] data source file path
  attr_accessor :data_source_file


  class << self
    def get_currencies
      self.new.get_currencies
    end
  end

  # @param service_response_file [String] (COUNTRIES_CURRENCIES_LIST_FILE_PATH)
  def initialize(service_response_file = COUNTRIES_CURRENCIES_LIST_FILE_PATH)
    @data_source_file = service_response_file
  end

  # @return [String] service raw response
  def get_currencies
    File.open(@data_source_file, "r") do |file|
      file.read
    end
  end
end

class ::Ct::WebServiceX::CountryService < ::Ct::WebServiceX::BaseService
  include ::Ct::WebServiceX::CountryServiceMixin


  client wsdl: "http://www.webservicex.net/country.asmx?WSDL"

  # @!method get_currencies
  #   @return [String]
  #   @example
  #
  #     raw_xml_response = country_service.get_currencies
  operations :get_currencies


  # @return [String] service raw response
  def get_currencies
#  rescue Exception => e
#    Rails.logger.error "Error retrieving SOAP Response: '#{e.message}'"
#    e.backtrace.each {|line| Rails.logger.error "- #{line}" }
#
#    return ""
    super.to_hash["#{__method__}_response".to_sym]["#{__method__}_result".to_sym]
  end
end

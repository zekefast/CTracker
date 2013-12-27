require "savon"


# Library to access SOAP services on www.webservicex.net.
#
# @example
#
#   country_service = ::Ct::WebServiceX.service(:country)
class ::Ct::WebServiceX
  include Singleton

  # All service class names are expected to and with that postfix.
  #
  # @return [String] postfix for service class
  SERVICE_CLASS_POSTFIX = "Service".freeze

  # @!attribute services
  #   @return [Hash<String=>::Ct::WebServiceX::BaseService] list of instantiated
  #     services
  attr_reader :services


  class << self
    # @see ::Ct::WebServiceX#service
    def service(name)
      instance.send(__method__, name)
    end
  end

  def initialize
    @services = {}
  end

  # Create new or reuse old instance of service to communicate with remote
  # services.
  #
  # @param name [String, Symbol] service name
  #
  # @return [::Ct::WebServiceX::BaseService] service instance
  #
  # @raise [::Ct::WebServiceX::ServiceNameError] in case of invalid or unknown
  #   service name.
  def service(name)
    service_name = name.to_s
    return @services[service_name] if @services.has_key?(service_name)

    class_name = service_class_name(service_name)
    unless self.class.const_defined?(class_name)
      raise ::Ct::WebServiceX::Error::ServiceNameError.service_class_not_found(name, class_name)
    end

    @services[service_name] = self.class.const_get(class_name).new
  end

  # Transform service name to class name of service.
  #
  # @param name [String] service name
  #
  # @return [String] service class name
  def service_class_name(name)
    name.classify + SERVICE_CLASS_POSTFIX
  end
end


require "ct/web_service_x/error"
require "ct/web_service_x/service_name_error"

require "ct/web_service_x/base_service"

require "ct/web_service_x/country_service_mixin"
require "ct/web_service_x/country_service"
require "ct/web_service_x/dummy_local_file_country_service"

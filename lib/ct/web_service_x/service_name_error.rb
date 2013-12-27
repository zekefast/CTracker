# Raised in case any problems with service name or service class name.
class ::Ct::WebServiceX::Error::ServiceName < RuntimeError
  include ::Ct::WebServiceX::Error

  # @!attribute service_name
  #   @return [String, Symbol]
  # @!attribute service_class
  #   @return [String]
  attr_accessor :service_name, :service_class


  # Create instance or error and prefill it with error message and
  # related information.
  #
  # @param service_name  [String, Symbol] name of unknown service
  # @param service_class [String]         name of class which could not be found
  #
  # @return [self] exception instance with verbose error message and linked
  #   error information
  def self.service_class_not_found(service_name, service_class)
    error = new(
      "Service class '#{service_class}' can not be found. " /
      "Probably service name '#{service_name}' is unknown or invalid.")

    error.serivce_name  = service_name
    error.service_class = service_class

    error
  end
end

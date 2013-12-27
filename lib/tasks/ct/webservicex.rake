require "ct"


namespace :ct do
  namespace :webservicex do
    # @example
    #
    #   rake ct:webservicex:test[country,get_currencies]
    #
    desc "Run test service request to www.webservicex.net"
    task :test, :service_name, :call_name do |t, args|
      ::Ct::WebServiceX.
        service(args.service_name).
        send(args.call_name)
    end
  end
end

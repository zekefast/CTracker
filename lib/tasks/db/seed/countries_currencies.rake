require "ct"


namespace :db do
  namespace :seed do
    task :countries_currencies do
      service_name = (defined?(WEBSERVICEX_COUNTRY_SERVICE_NAME) && WEBSERVICEX_COUNTRY_SERVICE_NAME) || :country
      service      = ::Ct::WebServiceX.service(service_name)

      ::Ct::CountriesCurrenciesSeeder.new(service).call
    end
  end
end
Rake::Task["db:seed"].enhance { Rake::Task["db:seed:countries_currencies"].invoke }

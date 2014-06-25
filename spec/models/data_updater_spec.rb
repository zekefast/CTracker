require "rails_helper"


RSpec.describe DataUpdater, :type => :model do
  subject(:instance) { DataUpdater.instance }


  describe "#parse_response" do
    let(:response) do
      {
        :get_currencies_response => {
          :get_currencies_result => "<NewDataSet>\n  <Table>\n    <Name>Afghanistan, Islamic State of</Name>\n    <CountryCode>af</CountryCode>\n    <Currency>Afghani</Currency>\n    <CurrencyCode>AFA</CurrencyCode>\n  </Table>\n  </NewDataSet>"
        }
      }
    end
    let(:expected) do
      {
        :countries  => [{ :name => "Afghanistan, Islamic State of", :code => "af" }],
        :currencies => [{ :name => "Afghani", :code => "AFA", :country_code => "af" }]
      }
    end

    subject { instance.parse_response(response) }

    before do
      DataUpdater.send(:public, :parse_response)
    end


    it "returns correct hash structure" do
      expect(subject).to eq(expected)
    end
  end # #parse_response
end

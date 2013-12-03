require 'savon'
require 'nokogiri'

class DataUpdater
  include Singleton

  def initialize
    @client = Savon.client(wsdl: "http://www.webservicex.net/country.asmx?WSDL")
  end

  def update
    response = get_soap_response
    return nil if response.nil?

    data = parse_response(response)
    data.keys.each do |key|
      data[key].each do |attributes|
        object = key.to_s.classify.constantize.find_or_create_by_code(attributes)
      end
    end
  end

  private

  def get_soap_response
    begin
      response = (defined?(USE_STATIC_DATA) && USE_STATIC_DATA) ? StaticSOAPResponse.new : @client.call(:get_currencies)
    rescue Exception => e
      Rails.logger.error "Error retrieving SOAP Response: '#{e.message}'"
      e.backtrace.each {|line| Rails.logger.error "- #{line}" }
      return nil
    end
  end

  # Returns a Hash with the following structure:
  #   { :currencies => [
  #       { :name => "Currency Name",
  #         :code => "Currency Code",
  #         :country_code => "Country Code"
  #       }
  #     ],
  #
  #     :countries => [
  #       { :name => "Country Name",
  #         :code => "Country Code"
  #       }
  #     ]
  #   }
  def parse_response( response = get_soap_response )
    doc = Nokogiri::XML::Document.parse( response.to_hash[:get_currencies_response][:get_currencies_result] )

    result = {}

    result[:currencies] = doc.css('Table').collect do |table|
      { :name => table.css('Currency').text,
        :code => table.css('CurrencyCode').text,
        :country_id => table.css('CountryCode').text
      }
    end

    result[:countries] = doc.css('Table').collect {|table| { :name => table.css('Name').text, :code => table.css('CountryCode').text } }

    result.keys.each {|key| result[key].reject! {|hash| hash[:name].blank? || hash[:code].blank? } }

    result
  end

  # Used in development mode, as the web service is not reliable.
  class StaticSOAPResponse
    def to_hash
      {
        get_currencies_response: {
          get_currencies_result: <<-RESULT,
<NewDataSet>
  <Table>
    <Name>Afghanistan, Islamic State of</Name>
    <CountryCode>af</CountryCode>
    <Currency>Afghani</Currency>
    <CurrencyCode>AFA</CurrencyCode>
  </Table>
  <Table>
    <Name>Albania</Name>
    <CountryCode>al</CountryCode>
    <Currency>Lek</Currency>
    <CurrencyCode>ALL</CurrencyCode>
  </Table>
  <Table>
    <Name>Algeria</Name>
    <CountryCode>dz</CountryCode>
    <Currency>Dinar</Currency>
    <CurrencyCode>DZD</CurrencyCode>
  </Table>
  <Table>
    <Name>American Samoa</Name>
    <CountryCode>as</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Andorra, Principality of</Name>
    <CountryCode>ad</CountryCode>
    <Currency>Franc</Currency>
    <CurrencyCode>ADF</CurrencyCode>
  </Table>
  <Table>
    <Name>Angola</Name>
    <CountryCode>ao</CountryCode>
    <Currency>New Kwanza</Currency>
    <CurrencyCode>AON</CurrencyCode>
  </Table>
  <Table>
    <Name>Anguilla</Name>
    <CountryCode>ai</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Antarctica</Name>
    <CountryCode>aq</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Antigua and Barbuda</Name>
    <CountryCode>ag</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Argentina</Name>
    <CountryCode>ar</CountryCode>
    <Currency>Peso </Currency>
    <CurrencyCode>ARS</CurrencyCode>
  </Table>
  <Table>
    <Name>Armenia</Name>
    <CountryCode>am</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Aruba</Name>
    <CountryCode>aw</CountryCode>
    <Currency>Florin </Currency>
    <CurrencyCode>AWG</CurrencyCode>
  </Table>
  <Table>
    <Name>Australia</Name>
    <CountryCode>au</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>AUD</CurrencyCode>
  </Table>
  <Table>
    <Name>Austria</Name>
    <CountryCode>at</CountryCode>
    <Currency>Schilling</Currency>
    <CurrencyCode>ATS</CurrencyCode>
  </Table>
  <Table>
    <Name>Azerbaidjan</Name>
    <CountryCode>az</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Bahamas</Name>
    <CountryCode>bs</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>BSD</CurrencyCode>
  </Table>
  <Table>
    <Name>Bahrain</Name>
    <CountryCode>bh</CountryCode>
    <Currency>Dinar</Currency>
    <CurrencyCode>BHD</CurrencyCode>
  </Table>
  <Table>
    <Name>Bangladesh</Name>
    <CountryCode>bd</CountryCode>
    <Currency>Taka</Currency>
    <CurrencyCode>BDT</CurrencyCode>
  </Table>
  <Table>
    <Name>Barbados</Name>
    <CountryCode>bb</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>BBD</CurrencyCode>
  </Table>
  <Table>
    <Name>Belarus</Name>
    <CountryCode>by</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Belgium</Name>
    <CountryCode>be</CountryCode>
    <Currency>Franc</Currency>
    <CurrencyCode>BEF</CurrencyCode>
  </Table>
  <Table>
    <Name>Belize</Name>
    <CountryCode>bz</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>BZD</CurrencyCode>
  </Table>
  <Table>
    <Name>Benin</Name>
    <CountryCode>bj</CountryCode>
    <Currency>CFA Franc </Currency>
    <CurrencyCode>XOF</CurrencyCode>
  </Table>
  <Table>
    <Name>Bermuda</Name>
    <CountryCode>bm</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>BMD</CurrencyCode>
  </Table>
  <Table>
    <Name>Bhutan</Name>
    <CountryCode>bt</CountryCode>
    <Currency>Ngultrum</Currency>
    <CurrencyCode>BTN</CurrencyCode>
  </Table>
  <Table>
    <Name>Bolivia</Name>
    <CountryCode>bo</CountryCode>
    <Currency>Boliviano</Currency>
    <CurrencyCode>BOB</CurrencyCode>
  </Table>
  <Table>
    <Name>Bosnia-Herzegovina</Name>
    <CountryCode>ba</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Botswana</Name>
    <CountryCode>bw</CountryCode>
    <Currency>Pula</Currency>
    <CurrencyCode>BWP</CurrencyCode>
  </Table>
  <Table>
    <Name>Bouvet Island</Name>
    <CountryCode>bv</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Brazil</Name>
    <CountryCode>br</CountryCode>
    <Currency>Cruzeiro</Currency>
    <CurrencyCode>BRC</CurrencyCode>
  </Table>
  <Table>
    <Name>British Indian Ocean Territory</Name>
    <CountryCode>io</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Brunei Darussalam</Name>
    <CountryCode>bn</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>BND</CurrencyCode>
  </Table>
  <Table>
    <Name>Bulgaria</Name>
    <CountryCode>bg</CountryCode>
    <Currency>Lev</Currency>
    <CurrencyCode>BGL</CurrencyCode>
  </Table>
  <Table>
    <Name>Burkina Faso</Name>
    <CountryCode>bf</CountryCode>
    <Currency>CFA Franc </Currency>
    <CurrencyCode>XOF</CurrencyCode>
  </Table>
  <Table>
    <Name>Burundi</Name>
    <CountryCode>bi</CountryCode>
    <Currency>Franc</Currency>
    <CurrencyCode>BIF</CurrencyCode>
  </Table>
  <Table>
    <Name>Cambodia, Kingdom of</Name>
    <CountryCode>kh</CountryCode>
    <Currency>Riel </Currency>
    <CurrencyCode>KHR</CurrencyCode>
  </Table>
  <Table>
    <Name>Cameroon</Name>
    <CountryCode>cm</CountryCode>
    <Currency>CFA Franc </Currency>
    <CurrencyCode>XAF</CurrencyCode>
  </Table>
  <Table>
    <Name>Canada</Name>
    <CountryCode>ca</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>CAD</CurrencyCode>
  </Table>
  <Table>
    <Name>Cape Verde</Name>
    <CountryCode>cv</CountryCode>
    <Currency>Escudo</Currency>
    <CurrencyCode>CVE</CurrencyCode>
  </Table>
  <Table>
    <Name>Cayman Islands</Name>
    <CountryCode>ky</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>KYD</CurrencyCode>
  </Table>
  <Table>
    <Name>Central African Republic</Name>
    <CountryCode>cf</CountryCode>
    <Currency>CFA Franc </Currency>
    <CurrencyCode>XAF</CurrencyCode>
  </Table>
  <Table>
    <Name>Chad</Name>
    <CountryCode>td</CountryCode>
    <Currency>CFA Franc BEAC</Currency>
    <CurrencyCode>XAF</CurrencyCode>
  </Table>
  <Table>
    <Name>Chile</Name>
    <CountryCode>cl</CountryCode>
    <Currency>Peso</Currency>
    <CurrencyCode>CLP</CurrencyCode>
  </Table>
  <Table>
    <Name>China</Name>
    <CountryCode>cn</CountryCode>
    <Currency>Yuan Renminbi</Currency>
    <CurrencyCode>CNY</CurrencyCode>
  </Table>
  <Table>
    <Name>Christmas Island</Name>
    <CountryCode>cx</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Cocos (Keeling) Islands</Name>
    <CountryCode>cc</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Colombia</Name>
    <CountryCode>co</CountryCode>
    <Currency>Peso</Currency>
    <CurrencyCode>COP</CurrencyCode>
  </Table>
  <Table>
    <Name>Comoros</Name>
    <CountryCode>km</CountryCode>
    <Currency>Franc</Currency>
    <CurrencyCode>KMF</CurrencyCode>
  </Table>
  <Table>
    <Name>Congo</Name>
    <CountryCode>cg</CountryCode>
    <Currency>CFA Franc BEAC</Currency>
    <CurrencyCode>XAF</CurrencyCode>
  </Table>
  <Table>
    <Name>Congo, The Democratic Republic of the</Name>
    <CountryCode>cd</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Cook Islands</Name>
    <CountryCode>ck</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Costa Rica</Name>
    <CountryCode>cr</CountryCode>
    <Currency>Colon</Currency>
    <CurrencyCode>CRC</CurrencyCode>
  </Table>
  <Table>
    <Name>Croatia</Name>
    <CountryCode>hr</CountryCode>
    <Currency>Kuna</Currency>
    <CurrencyCode>HRK</CurrencyCode>
  </Table>
  <Table>
    <Name>Cuba</Name>
    <CountryCode>cu</CountryCode>
    <Currency>Peso</Currency>
    <CurrencyCode>CUP</CurrencyCode>
  </Table>
  <Table>
    <Name>Cyprus</Name>
    <CountryCode>cy</CountryCode>
    <Currency>Pound</Currency>
    <CurrencyCode>CVP</CurrencyCode>
  </Table>
  <Table>
    <Name>Czech Republic</Name>
    <CountryCode>cz</CountryCode>
    <Currency>Koruna</Currency>
    <CurrencyCode>CSK</CurrencyCode>
  </Table>
  <Table>
    <Name>Denmark</Name>
    <CountryCode>dk</CountryCode>
    <Currency>Guilder</Currency>
    <CurrencyCode>DKK</CurrencyCode>
  </Table>
  <Table>
    <Name>Djibouti</Name>
    <CountryCode>dj</CountryCode>
    <Currency>Franc</Currency>
    <CurrencyCode>DJF</CurrencyCode>
  </Table>
  <Table>
    <Name>Dominica</Name>
    <CountryCode>dm</CountryCode>
    <Currency>Peso</Currency>
    <CurrencyCode>DOP</CurrencyCode>
  </Table>
  <Table>
    <Name>Dominican Republic</Name>
    <CountryCode>do</CountryCode>
    <Currency>Peso</Currency>
    <CurrencyCode>DOP</CurrencyCode>
  </Table>
  <Table>
    <Name>East Timor</Name>
    <CountryCode>tp</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Ecuador</Name>
    <CountryCode>ec</CountryCode>
    <Currency>Sucre</Currency>
    <CurrencyCode>ECS</CurrencyCode>
  </Table>
  <Table>
    <Name>Egypt</Name>
    <CountryCode>eg</CountryCode>
    <Currency>Pound</Currency>
    <CurrencyCode>EGP</CurrencyCode>
  </Table>
  <Table>
    <Name>El Salvador</Name>
    <CountryCode>sv</CountryCode>
    <Currency>Colon</Currency>
    <CurrencyCode>SVC</CurrencyCode>
  </Table>
  <Table>
    <Name>Equatorial Guinea</Name>
    <CountryCode>gq</CountryCode>
    <Currency>CFA </Currency>
    <CurrencyCode>XAF</CurrencyCode>
  </Table>
  <Table>
    <Name>Eritrea</Name>
    <CountryCode>er</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Estonia</Name>
    <CountryCode>ee</CountryCode>
    <Currency>Kroon</Currency>
    <CurrencyCode>EEK</CurrencyCode>
  </Table>
  <Table>
    <Name>Ethiopia</Name>
    <CountryCode>et</CountryCode>
    <Currency>Birr</Currency>
    <CurrencyCode>ETB</CurrencyCode>
  </Table>
  <Table>
    <Name>Falkland Islands</Name>
    <CountryCode>fk</CountryCode>
    <Currency>Pound</Currency>
    <CurrencyCode>FKP</CurrencyCode>
  </Table>
  <Table>
    <Name>Faroe Islands</Name>
    <CountryCode>fo</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Fiji</Name>
    <CountryCode>fj</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>FJD</CurrencyCode>
  </Table>
  <Table>
    <Name>Finland</Name>
    <CountryCode>fi</CountryCode>
    <Currency>Markka</Currency>
    <CurrencyCode>FIM</CurrencyCode>
  </Table>
  <Table>
    <Name>Former Czechoslovakia</Name>
    <CountryCode>cs</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Former USSR</Name>
    <CountryCode>su</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>France</Name>
    <CountryCode>fr</CountryCode>
    <Currency>Franc</Currency>
    <CurrencyCode>FRF</CurrencyCode>
  </Table>
  <Table>
    <Name>France (European Territory)</Name>
    <CountryCode>fx</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>French Guyana</Name>
    <CountryCode>gf</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>French Southern Territories</Name>
    <CountryCode>tf</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Gabon</Name>
    <CountryCode>ga</CountryCode>
    <Currency>CFA Franc BEAC</Currency>
    <CurrencyCode>XAF</CurrencyCode>
  </Table>
  <Table>
    <Name>Gambia</Name>
    <CountryCode>gm</CountryCode>
    <Currency>Dalasi</Currency>
    <CurrencyCode>GMD</CurrencyCode>
  </Table>
  <Table>
    <Name>Georgia</Name>
    <CountryCode>ge</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Germany</Name>
    <CountryCode>de</CountryCode>
    <Currency>Mark</Currency>
    <CurrencyCode>DEM</CurrencyCode>
  </Table>
  <Table>
    <Name>Ghana</Name>
    <CountryCode>gh</CountryCode>
    <Currency>Cedi</Currency>
    <CurrencyCode>GHC</CurrencyCode>
  </Table>
  <Table>
    <Name>Gibraltar</Name>
    <CountryCode>gi</CountryCode>
    <Currency>Pound</Currency>
    <CurrencyCode>GIP</CurrencyCode>
  </Table>
  <Table>
    <Name>Great Britain</Name>
    <CountryCode>gb</CountryCode>
    <Currency>Sterling</Currency>
    <CurrencyCode>GBP</CurrencyCode>
  </Table>
  <Table>
    <Name>Greece</Name>
    <CountryCode>gr</CountryCode>
    <Currency>Drachma</Currency>
    <CurrencyCode>GRD</CurrencyCode>
  </Table>
  <Table>
    <Name>Greenland</Name>
    <CountryCode>gl</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Grenada</Name>
    <CountryCode>gd</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Guadeloupe (French)</Name>
    <CountryCode>gp</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Guam (USA)</Name>
    <CountryCode>gu</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Guatemala</Name>
    <CountryCode>gt</CountryCode>
    <Currency>Quetzal</Currency>
    <CurrencyCode>GTQ</CurrencyCode>
  </Table>
  <Table>
    <Name>Guinea</Name>
    <CountryCode>gn</CountryCode>
    <Currency>Franc</Currency>
    <CurrencyCode>GNF</CurrencyCode>
  </Table>
  <Table>
    <Name>Guinea Bissau</Name>
    <CountryCode>gw</CountryCode>
    <Currency>Peso</Currency>
    <CurrencyCode>GWP</CurrencyCode>
  </Table>
  <Table>
    <Name>Guyana</Name>
    <CountryCode>gy</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>GYD</CurrencyCode>
  </Table>
  <Table>
    <Name>Haiti</Name>
    <CountryCode>ht</CountryCode>
    <Currency>Gourde</Currency>
    <CurrencyCode>HTG</CurrencyCode>
  </Table>
  <Table>
    <Name>Heard and McDonald Islands</Name>
    <CountryCode>hm</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Holy See (Vatican City State)</Name>
    <CountryCode>va</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Honduras</Name>
    <CountryCode>hn</CountryCode>
    <Currency>Lempira</Currency>
    <CurrencyCode>HNL</CurrencyCode>
  </Table>
  <Table>
    <Name>Hong Kong</Name>
    <CountryCode>hk</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>HKD</CurrencyCode>
  </Table>
  <Table>
    <Name>Hungary</Name>
    <CountryCode>hu</CountryCode>
    <Currency>Forint</Currency>
    <CurrencyCode>HUF</CurrencyCode>
  </Table>
  <Table>
    <Name>Iceland</Name>
    <CountryCode>is</CountryCode>
    <Currency>Krona</Currency>
    <CurrencyCode>ISK</CurrencyCode>
  </Table>
  <Table>
    <Name>India</Name>
    <CountryCode>in</CountryCode>
    <Currency>Rupee</Currency>
    <CurrencyCode>INR</CurrencyCode>
  </Table>
  <Table>
    <Name>Indonesia</Name>
    <CountryCode>id</CountryCode>
    <Currency>Rupiah</Currency>
    <CurrencyCode>IDR</CurrencyCode>
  </Table>
  <Table>
    <Name>Iran</Name>
    <CountryCode>ir</CountryCode>
    <Currency>Rial</Currency>
    <CurrencyCode>IRR</CurrencyCode>
  </Table>
  <Table>
    <Name>Iraq</Name>
    <CountryCode>iq</CountryCode>
    <Currency>Dinar</Currency>
    <CurrencyCode>IQD</CurrencyCode>
  </Table>
  <Table>
    <Name>Ireland</Name>
    <CountryCode>ie</CountryCode>
    <Currency>Punt</Currency>
    <CurrencyCode>IEP</CurrencyCode>
  </Table>
  <Table>
    <Name>Israel</Name>
    <CountryCode>il</CountryCode>
    <Currency>New Shekel</Currency>
    <CurrencyCode>ILS</CurrencyCode>
  </Table>
  <Table>
    <Name>Italy</Name>
    <CountryCode>it</CountryCode>
    <Currency>Lira</Currency>
    <CurrencyCode>ITL</CurrencyCode>
  </Table>
  <Table>
    <Name>Ivory Coast (Cote D'Ivoire)</Name>
    <CountryCode>ci</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Jamaica</Name>
    <CountryCode>jm</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>JMD</CurrencyCode>
  </Table>
  <Table>
    <Name>Japan</Name>
    <CountryCode>jp</CountryCode>
    <Currency>Yen</Currency>
    <CurrencyCode>JPY</CurrencyCode>
  </Table>
  <Table>
    <Name>Jordan</Name>
    <CountryCode>jo</CountryCode>
    <Currency>Dinar</Currency>
    <CurrencyCode>JOD</CurrencyCode>
  </Table>
  <Table>
    <Name>Kazakhstan</Name>
    <CountryCode>kz</CountryCode>
    <Currency>Tenge</Currency>
    <CurrencyCode>KZT</CurrencyCode>
  </Table>
  <Table>
    <Name>Kenya</Name>
    <CountryCode>ke</CountryCode>
    <Currency>Schilling</Currency>
    <CurrencyCode>KES</CurrencyCode>
  </Table>
  <Table>
    <Name>Kiribati</Name>
    <CountryCode>ki</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Kuwait</Name>
    <CountryCode>kw</CountryCode>
    <Currency>Dinar</Currency>
    <CurrencyCode>KWD</CurrencyCode>
  </Table>
  <Table>
    <Name>Kyrgyz Republic (Kyrgyzstan)</Name>
    <CountryCode>kg</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Laos</Name>
    <CountryCode>la</CountryCode>
    <Currency>Kip</Currency>
    <CurrencyCode>LAK</CurrencyCode>
  </Table>
  <Table>
    <Name>Latvia</Name>
    <CountryCode>lv</CountryCode>
    <Currency>Lats</Currency>
    <CurrencyCode>LVL</CurrencyCode>
  </Table>
  <Table>
    <Name>Lebanon</Name>
    <CountryCode>lb</CountryCode>
    <Currency>Pound</Currency>
    <CurrencyCode>LBP</CurrencyCode>
  </Table>
  <Table>
    <Name>Lesotho</Name>
    <CountryCode>ls</CountryCode>
    <Currency>Loti</Currency>
    <CurrencyCode>LSL</CurrencyCode>
  </Table>
  <Table>
    <Name>Liberia</Name>
    <CountryCode>lr</CountryCode>
    <Currency> Dollar</Currency>
    <CurrencyCode>LRD</CurrencyCode>
  </Table>
  <Table>
    <Name>Libya</Name>
    <CountryCode>ly</CountryCode>
    <Currency>Dinar</Currency>
    <CurrencyCode>LYD</CurrencyCode>
  </Table>
  <Table>
    <Name>Liechtenstein</Name>
    <CountryCode>li</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Lithuania</Name>
    <CountryCode>lt</CountryCode>
    <Currency>Litas</Currency>
    <CurrencyCode>LTL</CurrencyCode>
  </Table>
  <Table>
    <Name>Luxembourg</Name>
    <CountryCode>lu</CountryCode>
    <Currency>Franc</Currency>
    <CurrencyCode>LUF</CurrencyCode>
  </Table>
  <Table>
    <Name>Macau</Name>
    <CountryCode>mo</CountryCode>
    <Currency>Pataca</Currency>
    <CurrencyCode>MOP</CurrencyCode>
  </Table>
  <Table>
    <Name>Macedonia</Name>
    <CountryCode>mk</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Madagascar</Name>
    <CountryCode>mg</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Malawi</Name>
    <CountryCode>mw</CountryCode>
    <Currency>Kwacha</Currency>
    <CurrencyCode>MWK</CurrencyCode>
  </Table>
  <Table>
    <Name>Malaysia</Name>
    <CountryCode>my</CountryCode>
    <Currency>Ringgit</Currency>
    <CurrencyCode>MYR</CurrencyCode>
  </Table>
  <Table>
    <Name>Maldives</Name>
    <CountryCode>mv</CountryCode>
    <Currency>Rufiyaa</Currency>
    <CurrencyCode>MVR</CurrencyCode>
  </Table>
  <Table>
    <Name>Mali</Name>
    <CountryCode>ml</CountryCode>
    <Currency>CFA Franc BCEAO</Currency>
    <CurrencyCode>XOF</CurrencyCode>
  </Table>
  <Table>
    <Name>Malta</Name>
    <CountryCode>mt</CountryCode>
    <Currency>Lira</Currency>
    <CurrencyCode>MTL</CurrencyCode>
  </Table>
  <Table>
    <Name>Marshall Islands</Name>
    <CountryCode>mh</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Martinique (French)</Name>
    <CountryCode>mq</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Mauritania</Name>
    <CountryCode>mr</CountryCode>
    <Currency>Ouguiya</Currency>
    <CurrencyCode>MRO</CurrencyCode>
  </Table>
  <Table>
    <Name>Mauritius</Name>
    <CountryCode>mu</CountryCode>
    <Currency>Rupee</Currency>
    <CurrencyCode>MUR</CurrencyCode>
  </Table>
  <Table>
    <Name>Mayotte</Name>
    <CountryCode>yt</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Mexico</Name>
    <CountryCode>mx</CountryCode>
    <Currency>Peso</Currency>
    <CurrencyCode>MXP</CurrencyCode>
  </Table>
  <Table>
    <Name>Micronesia</Name>
    <CountryCode>fm</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Moldavia</Name>
    <CountryCode>md</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Monaco</Name>
    <CountryCode>mc</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Mongolia</Name>
    <CountryCode>mn</CountryCode>
    <Currency>Tugrik</Currency>
    <CurrencyCode>MNT</CurrencyCode>
  </Table>
  <Table>
    <Name>Montserrat</Name>
    <CountryCode>ms</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Morocco</Name>
    <CountryCode>ma</CountryCode>
    <Currency>Dirham</Currency>
    <CurrencyCode>MAD</CurrencyCode>
  </Table>
  <Table>
    <Name>Mozambique</Name>
    <CountryCode>mz</CountryCode>
    <Currency>Metical</Currency>
    <CurrencyCode>MZM</CurrencyCode>
  </Table>
  <Table>
    <Name>Myanmar</Name>
    <CountryCode>mm</CountryCode>
    <Currency>Kyat</Currency>
    <CurrencyCode>MMK</CurrencyCode>
  </Table>
  <Table>
    <Name>Namibia</Name>
    <CountryCode>na</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Nauru</Name>
    <CountryCode>nr</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Nepal</Name>
    <CountryCode>np</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Netherlands</Name>
    <CountryCode>nl</CountryCode>
    <Currency>Guilder</Currency>
    <CurrencyCode>NLG</CurrencyCode>
  </Table>
  <Table>
    <Name>Netherlands Antilles</Name>
    <CountryCode>an</CountryCode>
    <Currency>Antillian Guilder</Currency>
    <CurrencyCode>ANG</CurrencyCode>
  </Table>
  <Table>
    <Name>Neutral Zone</Name>
    <CountryCode>nt</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>New Caledonia (French)</Name>
    <CountryCode>nc</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>New Zealand</Name>
    <CountryCode>nz</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>NZD</CurrencyCode>
  </Table>
  <Table>
    <Name>Nicaragua</Name>
    <CountryCode>ni</CountryCode>
    <Currency>Cordoba Oro</Currency>
    <CurrencyCode>NIO</CurrencyCode>
  </Table>
  <Table>
    <Name>Niger</Name>
    <CountryCode>ne</CountryCode>
    <Currency>CFA Franc</Currency>
    <CurrencyCode>XOF</CurrencyCode>
  </Table>
  <Table>
    <Name>Nigeria</Name>
    <CountryCode>ng</CountryCode>
    <Currency>Naira</Currency>
    <CurrencyCode>NGN</CurrencyCode>
  </Table>
  <Table>
    <Name>Niue</Name>
    <CountryCode>nu</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Norfolk Island</Name>
    <CountryCode>nf</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>North Korea</Name>
    <CountryCode>kp</CountryCode>
    <Currency>Won</Currency>
    <CurrencyCode>KPW</CurrencyCode>
  </Table>
  <Table>
    <Name>Northern Mariana Islands</Name>
    <CountryCode>mp</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Norway</Name>
    <CountryCode>no</CountryCode>
    <Currency>Kroner</Currency>
    <CurrencyCode>NOK</CurrencyCode>
  </Table>
  <Table>
    <Name>Oman</Name>
    <CountryCode>om</CountryCode>
    <Currency>Rial</Currency>
    <CurrencyCode>OMR</CurrencyCode>
  </Table>
  <Table>
    <Name>Pakistan</Name>
    <CountryCode>pk</CountryCode>
    <Currency>Rupee</Currency>
    <CurrencyCode>PKR</CurrencyCode>
  </Table>
  <Table>
    <Name>Palau</Name>
    <CountryCode>pw</CountryCode>
    <Currency>oz</Currency>
    <CurrencyCode>XPD</CurrencyCode>
  </Table>
  <Table>
    <Name>Panama</Name>
    <CountryCode>pa</CountryCode>
    <Currency>Balboa</Currency>
    <CurrencyCode>PAB</CurrencyCode>
  </Table>
  <Table>
    <Name>Papua New Guinea</Name>
    <CountryCode>pg</CountryCode>
    <Currency>Kina</Currency>
    <CurrencyCode>PGK</CurrencyCode>
  </Table>
  <Table>
    <Name>Paraguay</Name>
    <CountryCode>py</CountryCode>
    <Currency>Guarani</Currency>
    <CurrencyCode>PYG</CurrencyCode>
  </Table>
  <Table>
    <Name>Peru</Name>
    <CountryCode>pe</CountryCode>
    <Currency>Neuevo Sol</Currency>
    <CurrencyCode>PEN</CurrencyCode>
  </Table>
  <Table>
    <Name>Philippines</Name>
    <CountryCode>ph</CountryCode>
    <Currency>Peso</Currency>
    <CurrencyCode>PHP</CurrencyCode>
  </Table>
  <Table>
    <Name>Pitcairn Island</Name>
    <CountryCode>pn</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Poland</Name>
    <CountryCode>pl</CountryCode>
    <Currency>Zloty</Currency>
    <CurrencyCode>PLZ</CurrencyCode>
  </Table>
  <Table>
    <Name>Polynesia (French)</Name>
    <CountryCode>pf</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Portugal</Name>
    <CountryCode>pt</CountryCode>
    <Currency>Escudo</Currency>
    <CurrencyCode>PTE</CurrencyCode>
  </Table>
  <Table>
    <Name>Puerto Rico</Name>
    <CountryCode>pr</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Qatar</Name>
    <CountryCode>qa</CountryCode>
    <Currency>Rial</Currency>
    <CurrencyCode>QAR</CurrencyCode>
  </Table>
  <Table>
    <Name>Reunion (French)</Name>
    <CountryCode>re</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Romania</Name>
    <CountryCode>ro</CountryCode>
    <Currency>Leu</Currency>
    <CurrencyCode>ROL</CurrencyCode>
  </Table>
  <Table>
    <Name>Russian Federation</Name>
    <CountryCode>ru</CountryCode>
    <Currency>Rouble</Currency>
    <CurrencyCode>RUB</CurrencyCode>
  </Table>
  <Table>
    <Name>Rwanda</Name>
    <CountryCode>rw</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>S. Georgia &amp; S. Sandwich Isls.</Name>
    <CountryCode>gs</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Saint Helena</Name>
    <CountryCode>sh</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Saint Kitts &amp; Nevis Anguilla</Name>
    <CountryCode>kn</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Saint Lucia</Name>
    <CountryCode>lc</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Saint Pierre and Miquelon</Name>
    <CountryCode>pm</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Saint Tome (Sao Tome) and Principe</Name>
    <CountryCode>st</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Saint Vincent &amp; Grenadines</Name>
    <CountryCode>vc</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Samoa</Name>
    <CountryCode>ws</CountryCode>
    <Currency>Tala</Currency>
    <CurrencyCode>WST</CurrencyCode>
  </Table>
  <Table>
    <Name>San Marino</Name>
    <CountryCode>sm</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Saudi Arabia</Name>
    <CountryCode>sa</CountryCode>
    <Currency>Riyal</Currency>
    <CurrencyCode>SAR</CurrencyCode>
  </Table>
  <Table>
    <Name>Senegal</Name>
    <CountryCode>sn</CountryCode>
    <Currency>CFA Franc </Currency>
    <CurrencyCode>XOF</CurrencyCode>
  </Table>
  <Table>
    <Name>Seychelles</Name>
    <CountryCode>sc</CountryCode>
    <Currency>Rupee</Currency>
    <CurrencyCode>SCR</CurrencyCode>
  </Table>
  <Table>
    <Name>Sierra Leone</Name>
    <CountryCode>sl</CountryCode>
    <Currency>Leone</Currency>
    <CurrencyCode>SLL</CurrencyCode>
  </Table>
  <Table>
    <Name>Singapore</Name>
    <CountryCode>sg</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>SGD</CurrencyCode>
  </Table>
  <Table>
    <Name>Slovak Republic</Name>
    <CountryCode>sk</CountryCode>
    <Currency>Koruna</Currency>
    <CurrencyCode>SKK</CurrencyCode>
  </Table>
  <Table>
    <Name>Slovenia</Name>
    <CountryCode>si</CountryCode>
    <Currency>Tolar</Currency>
    <CurrencyCode>SIT</CurrencyCode>
  </Table>
  <Table>
    <Name>Solomon Islands</Name>
    <CountryCode>sb</CountryCode>
    <Currency> Dollar</Currency>
    <CurrencyCode>SBD</CurrencyCode>
  </Table>
  <Table>
    <Name>Somalia</Name>
    <CountryCode>so</CountryCode>
    <Currency>Schilling</Currency>
    <CurrencyCode>SOS</CurrencyCode>
  </Table>
  <Table>
    <Name>South Africa</Name>
    <CountryCode>za</CountryCode>
    <Currency>Rand</Currency>
    <CurrencyCode>ZAR</CurrencyCode>
  </Table>
  <Table>
    <Name>South Korea</Name>
    <CountryCode>kr</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Spain</Name>
    <CountryCode>es</CountryCode>
    <Currency>Peseta</Currency>
    <CurrencyCode>ESP</CurrencyCode>
  </Table>
  <Table>
    <Name>Sri Lanka</Name>
    <CountryCode>lk</CountryCode>
    <Currency>Rupee</Currency>
    <CurrencyCode>LKR</CurrencyCode>
  </Table>
  <Table>
    <Name>Sudan</Name>
    <CountryCode>sd</CountryCode>
    <Currency>Dinar</Currency>
    <CurrencyCode>SDD</CurrencyCode>
  </Table>
  <Table>
    <Name>Suriname</Name>
    <CountryCode>sr</CountryCode>
    <Currency>Guilder</Currency>
    <CurrencyCode>SRG</CurrencyCode>
  </Table>
  <Table>
    <Name>Svalbard and Jan Mayen Islands</Name>
    <CountryCode>sj</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Swaziland</Name>
    <CountryCode>sz</CountryCode>
    <Currency>Lilangeni</Currency>
    <CurrencyCode>SZL</CurrencyCode>
  </Table>
  <Table>
    <Name>Sweden</Name>
    <CountryCode>se</CountryCode>
    <Currency>Krona</Currency>
    <CurrencyCode>SEK</CurrencyCode>
  </Table>
  <Table>
    <Name>Switzerland</Name>
    <CountryCode>ch</CountryCode>
    <Currency>Franc</Currency>
    <CurrencyCode>CHF</CurrencyCode>
  </Table>
  <Table>
    <Name>Syria</Name>
    <CountryCode>sy</CountryCode>
    <Currency>Pound</Currency>
    <CurrencyCode>SYP</CurrencyCode>
  </Table>
  <Table>
    <Name>Tadjikistan</Name>
    <CountryCode>tj</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Taiwan</Name>
    <CountryCode>tw</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>TWD</CurrencyCode>
  </Table>
  <Table>
    <Name>Tanzania</Name>
    <CountryCode>tz</CountryCode>
    <Currency>Schilling</Currency>
    <CurrencyCode>TZS</CurrencyCode>
  </Table>
  <Table>
    <Name>Thailand</Name>
    <CountryCode>th</CountryCode>
    <Currency>Baht</Currency>
    <CurrencyCode>THB</CurrencyCode>
  </Table>
  <Table>
    <Name>Togo</Name>
    <CountryCode>tg</CountryCode>
    <Currency>CFA Franc BCEAO</Currency>
    <CurrencyCode>XOF</CurrencyCode>
  </Table>
  <Table>
    <Name>Tokelau</Name>
    <CountryCode>tk</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Tonga</Name>
    <CountryCode>to</CountryCode>
    <Currency>Pa'anga</Currency>
    <CurrencyCode>TOP</CurrencyCode>
  </Table>
  <Table>
    <Name>Trinidad and Tobago</Name>
    <CountryCode>tt</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>TTD</CurrencyCode>
  </Table>
  <Table>
    <Name>Tunisia</Name>
    <CountryCode>tn</CountryCode>
    <Currency>Dinar</Currency>
    <CurrencyCode>TND</CurrencyCode>
  </Table>
  <Table>
    <Name>Turkey</Name>
    <CountryCode>tr</CountryCode>
    <Currency>Lira</Currency>
    <CurrencyCode>TRL</CurrencyCode>
  </Table>
  <Table>
    <Name>Turkmenistan</Name>
    <CountryCode>tm</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Turks and Caicos Islands</Name>
    <CountryCode>tc</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Tuvalu</Name>
    <CountryCode>tv</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Uganda</Name>
    <CountryCode>ug</CountryCode>
    <Currency>Schilling</Currency>
    <CurrencyCode>UGS</CurrencyCode>
  </Table>
  <Table>
    <Name>Ukraine</Name>
    <CountryCode>ua</CountryCode>
    <Currency>Hryvnia</Currency>
    <CurrencyCode>UAG</CurrencyCode>
  </Table>
  <Table>
    <Name>United Arab Emirates</Name>
    <CountryCode>ae</CountryCode>
    <Currency>Dirham</Currency>
    <CurrencyCode>AED</CurrencyCode>
  </Table>
  <Table>
    <Name>United Kingdom</Name>
    <CountryCode>uk</CountryCode>
    <Currency>Pound</Currency>
    <CurrencyCode>GBP</CurrencyCode>
  </Table>
  <Table>
    <Name>United States</Name>
    <CountryCode>us</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>USD</CurrencyCode>
  </Table>
  <Table>
    <Name>Uruguay</Name>
    <CountryCode>uy</CountryCode>
    <Currency>Peso</Currency>
    <CurrencyCode>UYP</CurrencyCode>
  </Table>
  <Table>
    <Name>USA Minor Outlying Islands</Name>
    <CountryCode>um</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Uzbekistan</Name>
    <CountryCode>uz</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Vanuatu</Name>
    <CountryCode>vu</CountryCode>
    <Currency>Vatu</Currency>
    <CurrencyCode>VUV</CurrencyCode>
  </Table>
  <Table>
    <Name>Venezuela</Name>
    <CountryCode>ve</CountryCode>
    <Currency>Bolivar</Currency>
    <CurrencyCode>VEB</CurrencyCode>
  </Table>
  <Table>
    <Name>Vietnam</Name>
    <CountryCode>vn</CountryCode>
    <Currency>Dong</Currency>
    <CurrencyCode>VND</CurrencyCode>
  </Table>
  <Table>
    <Name>Virgin Islands (British)</Name>
    <CountryCode>vg</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Virgin Islands (USA)</Name>
    <CountryCode>vi</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Wallis and Futuna Islands</Name>
    <CountryCode>wf</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Western Sahara</Name>
    <CountryCode>eh</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Yemen</Name>
    <CountryCode>ye</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Yugoslavia</Name>
    <CountryCode>yu</CountryCode>
    <Currency>Dinar</Currency>
    <CurrencyCode>YUN</CurrencyCode>
  </Table>
  <Table>
    <Name>Zaire</Name>
    <CountryCode>zr</CountryCode>
    <Currency/>
    <CurrencyCode/>
  </Table>
  <Table>
    <Name>Zambia</Name>
    <CountryCode>zm</CountryCode>
    <Currency>Kwacha</Currency>
    <CurrencyCode>ZMK</CurrencyCode>
  </Table>
  <Table>
    <Name>Zimbabwe</Name>
    <CountryCode>zw</CountryCode>
    <Currency>Dollar</Currency>
    <CurrencyCode>ZWD</CurrencyCode>
  </Table>
</NewDataSet>
          RESULT
          xmlns: "http://www.webserviceX.NET"
        }
      }
    end
  end
end

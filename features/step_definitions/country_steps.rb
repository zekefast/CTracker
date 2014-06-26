Given /the following countries exist:/ do |countries|
  user = User.find_by(email: "testing@man.net")

  countries.hashes.each do |country_attributes|
    is_create_collection_item = country_attributes.delete("visited") == "true"
    country                   = Country.create!(country_attributes)

    if is_create_collection_item
      FactoryGirl.create(:collection_item,
        user:     user,
        currency: FactoryGirl.create(:currency, country: country))
    else
      FactoryGirl.create(:currency, country: country)
    end
  end
end

Then /^I should see the following table:$/ do |expected_table|
  document = Nokogiri::HTML(page.body)
  rows = document.css('section>table>tr').collect { |row| row.xpath('.//th|td').collect {|cell| cell.text } }

  expected_table.diff!(rows)
end

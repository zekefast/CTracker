Given /the following countries exist:/ do |countries|
  countries.hashes.reject { |c| c[:visited] == "true" }.each do |country|
    FactoryGirl.create(:currency, country: Country.create!(country))
  end

  user = User.find_by(email: "testing@man.net")
  countries.hashes.select { |country| country[:visited] == "true" }.each do |country|
    FactoryGirl.create(:collection_item, user: user, currency: FactoryGirl.create(:currency, country: Country.create!(country)))
  end
end

Then /^I should see the following table:$/ do |expected_table|
  document = Nokogiri::HTML(page.body)
  rows = document.css('section>table>tr').collect { |row| row.xpath('.//th|td').collect {|cell| cell.text } }

  expected_table.diff!(rows)
end

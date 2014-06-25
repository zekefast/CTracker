# Taken from https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Cucumber
Given /^I am not authenticated$/ do
  visit("/users/sign_out") # ensure that at least
end

Given /^I am a new, authenticated user$/ do
  email    = "testing@man.net"
  password = "secretpass"
  User.new(:email => email, :password => password, :password_confirmation => password).save!

  visit new_user_session_path
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"
end

Given /^I am a registered collector$/ do
  FactoryGirl.create(:user)
end

Given /^I am a collector registered with "([^"]+)" and "([^"]+)"$/ do |email, password|
  FactoryGirl.create(:user, email: email, password: password)
end

Given /^I am signed in with "([^"]+)" and "([^"]+)"$/ do |email, password|
  visit new_user_session_path
  fill_in "user_email",    with: email
  fill_in "user_password", with: password
  click_button "Sign in"
end

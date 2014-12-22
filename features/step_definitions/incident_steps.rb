# Dont forget about save_and_open_page
# http://www.launchacademy.com/codecabulary/learn-test-driven-development/rspec/capybara-cheat-sheet

Given(/^that I am at the new incident page$/) do
  visit new_incident_path
end

Given(/^that I am at the incidents page$/) do
  visit incidents_path
end

Given(/^the following user record:$/) do |table|
  table.hashes.each do |row|
    User.create!({email:row['email'], password:row['password'], admin:row['admin']})
  end
end

Given(/^I log in as "(.*?)" with password "(.*?)"$/) do |email, password|
  visit new_user_session_path
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  click_button "Log in"
end

When(/^I enter the following answers:$/) do |table|
#  save_and_open_page
  table.rows_hash.each do |row|
    if ["incident_incident_summary",
        "incident_location_state",
        "incident_department_name"].include?(row[0])
      fill_in row[0], with: row[1]
    else
      select row[1], from: row[0]
    end
  end
end

When(/^I click "(.*?)"$/) do |button|
  click_button button
end

Then(/^I should be on the incident index page$/) do
  expect(current_path).to eq(incidents_path)
end


And(/^I should see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

Then(/^I should have (\d+) incident$/) do |count|
  # Incident.count.should == count.to_i
  expect(Incident.count).to eq(count.to_i)
end

Then(/^I should not see "(.*?)" button$/) do |name|
  expect(page).to_not have_content(name)
end

include Warden::Test::Helpers
Warden.test_mode!

Given(/^that I am not authenticated$/) do
  logout(:user)
end

When(/^I visit contribution index page$/) do
  visit contributions_path
end

When(/^I visit new contribution page$/) do
  visit new_contribution_path
end

Then(/^I should be redirected to login page$/) do
  expect(current_path).to eq(new_user_session_path)
end

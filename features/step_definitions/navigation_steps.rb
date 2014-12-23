Given(/^I am at the root of the site$/) do
  visit root_path
end

Given(/^I am at the incidents index page$/) do
  visit incidents_path
end

Given(/^I am at the contributions index page$/) do
  visit contributions_path
end

Then(/^I should see a link to incidents$/) do
  expect(page).to have_link("Incidents", href: incidents_path)
end

Then(/^I should see a link to contributions$/) do
  expect(page).to have_link("Contributions", href: contributions_path)
end

Then(/^I should see a link to explore$/) do
  expect(page).to have_link("Explore", href: "/explore")
end

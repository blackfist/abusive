Given(/^that I am at the new contribution page$/) do
  visit new_contribution_path
end

When(/^I enter the following answers in new contribution form:$/) do |table|
#  save_and_open_page
  table.rows_hash.each do |row|
    fill_in row[0], with: row[1]
  end
end

Then(/^I should be on the contribution index page$/) do
  expect(current_path).to eq(contributions_path)
end

Then(/^I should have (\d+) contribution$/) do |count|
  expect(Contribution.count).to eq(count.to_i)
end

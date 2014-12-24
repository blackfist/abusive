Given(/^that I am at the new contribution page$/) do
  visit new_contribution_path
end

When(/^I go to that contribution show page$/) do
  @contrib = Contribution.last
  visit contribution_path(@contrib)
end


Given(/^the following contribution exists$/) do |table|
  Contribution.create!(table.rows_hash)
end

When(/^I enter the following answers in new contribution form:$/) do |table|
#  save_and_open_page
  table.rows_hash.each do |row|
    fill_in row[0], with: row[1]
  end
end

When(/^I select the following answers in new contribution form:$/) do |table|
  table.rows_hash.each do |row|
    select row[1], from: row[0]
  end
end

Then(/^I should be on the contribution index page$/) do
  expect(current_path).to eq(contributions_path)
end

Then(/^I should have (\d+) contribution$/) do |count|
  expect(Contribution.count).to eq(count.to_i)
end

Then(/^I should see the following information$/) do |table|
  table.rows_hash.each do |row|
    expect(page).to have_content(row[1])
  end
end

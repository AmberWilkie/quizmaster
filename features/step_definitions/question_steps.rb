Given(/^the following questions exist in "([^"]*)":$/) do |quiz_name, table|
  quiz = Quiz.find_by(name: quiz_name)
  table.hashes.each do |question|
    FactoryGirl.create(:question, body: question[:body], answer: question[:answer], quiz: quiz)
  end
end


When(/^I fill in the first "([^"]*)" with "([^"]*)"$/) do |field, content|
  # element = find(:css, '#question_id_1')
  within('#question_id_1') { fill_in field, with: content }

end
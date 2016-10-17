Given(/^there is a quiz called "([^"]*)"$/) do |name|
  FactoryGirl.create(:quiz, name: name)
end

Given(/^I am on the quiz page for "([^"]*)"$/) do |quiz_name|
  @quiz = Quiz.find_by(name: quiz_name)
  visit quizmaster_quiz_path(@quiz)
end

Then(/^I should see a quiz code$/) do
  expect(page).to have_content @quiz.code
end

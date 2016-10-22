Feature: As a Quizmaster
  in order to declare a winner
  I need to see a tally of Teams' correct Answers.

Background:
  Given there is a quiz called "Trivia"
  # And the following questions exist in "Trivia":
  #   | body            | answer       |
  #   | What is 2+2?    | Four         |
  #   | Who is awesome? | Thomas is ok |
  And there is a team named "Craft Academy" playing "Trivia"
  And there is a team named "Amber Rocks!" playing "Trivia"
  And "Craft Academy" has answered "10" questions right
  And "Amber Rocks!" has answered "11" questions right

Scenario: I view and send results
  And I am on the quizmaster page for "Trivia"
  When I click the "Results" button
  Then I should see "10"
  When "Amber Rocks!" is looking at the quiz page for "Trivia"
  And I click the "Send Results" button
  Then "Amber Rocks!" should see "Amber Rocks! won!"

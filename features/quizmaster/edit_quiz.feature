Feature: As a Quizmaster
  in order to perfect my quiz
  I must be able to edit a quiz.

  Background:
    Given there is a quizmaster with email "viktoria@quizmaster.com"
    And I am logged in as "viktoria@quizmaster.com"
    And "viktoria@quizmaster.com" has a quiz called "Team Craft Academy"

  Scenario: I edit my quiz
    Given I am on the edit quiz page for "Team Craft Academy"
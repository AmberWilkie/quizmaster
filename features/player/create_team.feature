
Feature: As a Player
  in order to join the game
  I need to be able to setup a Team.

  Background:
    Given there is a quiz called "Trivia"

  Scenario: Creating a Team
    Given I am on the page for "Trivia"
    When I fill in "Team Name" with "Eliten"
    And I click the "Create Team" button
    Then there should be a "team_id" cookie set to "1"
    And I should not see "Create Team"
    Then I should see "Successfully created team!"
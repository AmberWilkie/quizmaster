[![Build Status](https://travis-ci.org/CraftAcademy/quizmaster.svg?branch=develop)](https://travis-ci.org/CraftAcademy/quizmaster)
[![Coverage Status](https://coveralls.io/repos/github/CraftAcademy/quizmaster/badge.svg)](https://coveralls.io/github/CraftAcademy/quizmaster)


----------


## Introduction

Pub Quiz made digital. Users can author quizzes, then have their friends log in to send and receive answers in real time - no refreshing the page. All thanks to the magic of Rails' Action Cable.

You find the live app at [eQuizmaster.com](http://www.equizmaster.com/). Please feel free to use it for your next quiz night!

Built for [Craft Academy](http://www.craftacademy.se)'s programming bootcamp as a final project.

## Client

You can find the mobile client on [Github](https://github.com/AmberWilkie/quizmaster-client) or in the Android store (search for eQuizmaster).


## Technology
- Cucumber with Capybara and Poltergeist for acceptance testing
- Rspec with Shoulda-matchers for unit testing
- ActionCable for pushing out Questions and Answers
- Rails 5 as framework
- Devise
- Bootstrap

## Installation

Fork or clone the project, then in your project folder run:

```
bundle install
rails db:create
rails db:migrate
```
`rails db:seed` if you'd like to have some quizzes and teams pre-populated.

You also need to have a `redis server` running and a localhost server with two windows open, one on root path and one at `/quizmaster/quiz/:id`

## Tests

`rake` runs both rspec and cucumber tests

Testing ActionCable and using multiple browser-windows:
```
Scenario: I send the first question
  Given there is a "team_id" cookie set to "Craft Academy"
  When I am on the quiz page for "Trivia"
  And I switch to a new window
  And I am on the quizmaster page for "Trivia"
  When I press the "Send" button for question "1"
  And I switch to window "1"
  Then I should see "What is 2+2?"
```

## Contributors

[Pivotal tracker](https://www.pivotaltracker.com/n/projects/1901449)


- @thesuss (student)
- @amberwilkie (student)
- @blokkinen (student)
- @tochman (coach)
- @diraulo (coach)


## License

Can be found here:
[License](../blob/develop/LICENSE.md)

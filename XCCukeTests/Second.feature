
Feature: Running multiple feature files
    As a developer using BDD
    I want to use separate feature files to specify different features
    So that I can have more than one feature

Background:
    Given I add a second feature file

Scenario: Scenarios are parsed
    And the feature file has scenarios
    When I run the tests
    Then the scenarios will be run

Scenario: All Scenarios are run
    And the feature file has more scenarios
    When I run the tests
    Then the scenarios will be run

Scenario: Steps Have Correct Selectors
    When a step has an apostrophe
    Then it isn't capitalised strangely


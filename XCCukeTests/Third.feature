@tag1 @tag2 @tag3
Feature: Running multiple feature files
    As a developer using BDD
    I want to tag features and scenarios
    So that I can have fine-grained control over my test suites

Background:

Scenario: Scenarios include feature tags
    Given the feature file has tags
    When I run the tests
    Then the scenarios will be run

@tag4
Scenario: Scenario tags are parsed
    Given I tag a scenarios
    When A scenario has a tag
    Then the scenario object will include the tag

@tag3 @tag5 @tag6
Scenario: Scenario and Feature tags are cumulative
    Given the feature file has tags
    When a scenario also has a tag
    Then the scenario will include both sets of tags

Feature: Parsing feature files
    As a developer using BDD
    I want to use feature files to specify my app's behaviour
    So that I can sound like a business analyst

Background:
    Given I add a feature file

Scenario: Scenarios are parsed
    And the feature file has scenarios
    When I run the tests
    Then the scenarios will be run
Scenario: Comments are excluded
    And the feature file contains comments #like this one
    When the feature file #is parsed
# Without this line included
    Then the comments will be ignored


Scenario Outline: Scenario outlines are parsed
    And the feature has a scenario outline
    When the outline has <I say>
    Then the steps will be filled with <you say>

Examples:
    || I say     || You say    ||
    | black     | white     |
    | bark      | bite      |
    | shark     | hey man   |

Scenario: Special Characters in steps
    When the action_type is menu-tap
    Then the action_name is open-nav-dropdown

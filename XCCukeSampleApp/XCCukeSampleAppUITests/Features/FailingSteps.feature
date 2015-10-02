Feature: Failing steps
    As a developer
    I want my step definitions to fail when things go wrong
    So that I can understand what needs fixing

Scenario: Tests should fail when step definition not found
    Given I am on the root view
    When a step does not have a definition
    Then the scenario should fail

Scenario: Tests should fail when a step fails
    Given I am on the root view
    When a step has a failure
    Then the scenario should fail

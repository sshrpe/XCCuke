Feature: Device Actions
    As a developer
    I want to be able to make devices do things
    So that I can more effectively test hardware actions

Scenario: Tests should be able to rotate a device clockwise
    Given I am on the root view
    When I rotate my device clockwise
    Then my device should be in landscape orientation

Scenario: Tests should be able to rotate a device anti-clockwise
    Given I am on the root view
    When I rotate my device anti-clockwise
    Then my device should be in landscape orientation

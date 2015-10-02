Feature: Tapping buttons
    As a user
    I want the ability to tap buttons
    So that I can interact with the app

Scenario: Hello button says Hello
    Given I am on the root view
    When I tap on the Hello button
    Then the output label says 'Hello World'

Scenario Outline: All buttons say the right thing
    Given I am on the root view
    When I tap on the <button> button
    Then the output label says '<output>'
    | button    | output                |
    | Hello     | Hello World           |
    | Goodbye   | Goodbye Cruel World   |
    | Toodleoo  | TTFN                  |


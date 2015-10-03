# XCCuke

Testing library which allows executing Gherkin-style feature files in Xcode using XCTest.

## Setup/Installation

Include the XCCuke library in a Unit or UI test target to get started. 

The linker flags `-ObjC` and `all_load` must be added to the test target if not already present.

## Usage

### Running Scenarios From Feature Files

In order to run scenarios from a feature file, a subclass of `XCQTestSuite` must be included in the test 
target. The simplest way to get started is to use the macro `XCQ_INCLUDE_ALL_FEATURES_IN_BUNDLE()` in
the implementation of the `XCQTestSuite` subclass - this will create a test suite to run scenarios from all 
the feature files included in the test bundle:

```obj-c
@interface AllFeatures : XCQTestSuite

@end

@implementation AllFeatures

XCQ_INCLUDE_ALL_FEATURES_IN_BUNDLE()

XCQ_FEATURE_FILE_DIRECTORY(@"Features");

@end
```

If you would like Xcode to be able to highlight lines within feature files which are missing step definitions,
you can use the XCQ_FEATURE_FILE_DIRECTORY() macro in the subclass, passing it the path (relative to the 
current file) to the directory within your project which contains the feature files.

NB: Although it is possible to create an XCQTestSuite in Swift, the convenience macros are currently only 
available when using Objective-C. XCQStepDefinitions can be written in Objective-C or Swift.

### Pre- and Post-Scenario Hooks

The XCQTestSuite can return an observer from the `+testObserver` method, which can then be used to provide 
custom behaviour before and after scenarios. Observers must conform to the `XCQScenarioTestSuiteObserver`
protocol, which includes callbacks for the scenario starting, the scenario finishing, and the UI test server
becoming active (when using Xcode UI Test targets). See the documentation in the `XCQScenarioTestSuiteObserver` 
header for more information on what each observation method can be used for.

### Defining Steps

Step definitions must be implemented in a subclass of XCQStepDefinition (this is itself a subclass of XCTestCase 
and therefore allows using standard XCTest assertions), and can be created using Objective-C or Swift. Step 
definitions have no parameters and return void.

To define a step, create a method whose name matches the text of the step definition. The method name should:

- Have all spaces removed.
- Be title-cased.
- Not include the initial Given/When/Then/And
- Have all non-alphanumeric characters stripped.

For example, a step which reads "When I tap on the 'Hello' button" would be implemented in a method such as this:

```objc
// Objective-C
- (void)ITapOnTheHelloButton
{
	// Your test code goes here.
}
```
```swift
// Swift
func ITapOnTheHelloButton() {
	// Your test code goes here.
}
```

For scenario outlines, separate step defintions must be created for each example. For instance, to create steps
for a scenario such as this:

```gherkin
Scenario Outline: All buttons say the right thing
    Given I am on the root view
    When I tap on the <button> button
    Then the output label says '<output>'
    | button    | output                |
    | Hello     | Hello World           |
    | Goodbye   | Goodbye Cruel World   |
    | Toodleoo  | TTFN                  |

```

All of the following steps must be defined:

```obj-c
// Objective-C
- (void)ITapOnTheHelloButton;
- (void)ITapOnTheGoodbyeButton;
- (void)ITapOnTheToodleooButton;
- (void)TheOutputLabelSaysHelloWorld;
- (void)TheOutputLabelSaysGoodbyeCruelWorld;
- (void)TheOutputLabelSaysTtfn;
```
```swift
func ITapOnTheHelloButton()
func ITapOnTheGoodbyeButton()
func ITapOnTheToodleooButton()
func TheOutputLabelSaysHelloWorld()
func TheOutputLabelSaysGoodbyeCruelWorld()
func TheOutputLabelSaysTtfn()

```

If a step definition is not found, a test failure will be logged which includes the expected method signature 
of the step. This can be found in the console or by going to Xcode's 'Report navigator', selecting the test
run, opening the 'Logs' pane and viewing the log for the failed step.

## Areas For Future Development

- Add (or implement) an actual Gherkin Parser for loading scenarios from feature files.
- Scenario Tagging Support
- - Filter scenarios out using a tag
- - Automatically create test suites based on tags
- Pattern-Matching scenario names to allow data to be passed to scenarios.
- Improvements to the test runner to allow scenario state to be passed between step definitions.
- Improve Swift support for test suites.

## Known Issues

- Current 'parser' is not a true Gherkin parser and is severely limited in features.
- Scenarios currently continue to run after a step has failed in Xcode 7.
- Steps which begin with numbers 
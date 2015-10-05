//
//  GRFeatureTests.m
//  XCCuke
//
//  Created by Stuart Sharpe on 13/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import "XCQFeatureParser.h"
#import "XCQFeature.h"
#import "XCQScenario.h"
#import <XCTest/XCTest.h>
#import "XCQStep.h"

@interface XCQFeatureParserTests : XCTestCase

@end

@implementation XCQFeatureParserTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCorrectFeatureTitleParsed {
    // This is an example of a functional test case.
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Feature" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    
    XCTAssertEqualObjects([feature title], @"Parsing feature files");
}

- (void)testCorrectFeatureFileNameIsSet {
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Feature" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    
    XCTAssertEqualObjects([feature fileName], @"Feature.feature");

    featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Second" ofType:@"feature"];
    feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    
    XCTAssertEqualObjects([feature fileName], @"Second.feature");
}

- (void)testBackgroundIsParsed
{
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Feature" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    
    XCQScenario *background = [feature background];
    XCTAssertNotNil(background);
    XCTAssertEqualObjects(background.title, @"Background");
    
    XCQStep *firstStep = [[background steps] firstObject];
    XCTAssertEqualObjects([firstStep text], @"I add a feature file");
}

- (void)testCorrectNumberOfScenariosAddedToFeature
{
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Feature" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    
    XCTAssertEqual(6u, [[feature scenarios] count]);
}

- (void)testSimpleScenarioContainsAllSteps
{
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Feature" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    XCQScenario *firstScenario = [[feature scenarios] firstObject];
    
    XCTAssertEqualObjects(@"Scenarios are parsed", firstScenario.title);
    XCTAssertEqual(3u, [firstScenario.steps count]);
    XCTAssertEqualObjects(@"the feature file has scenarios", [firstScenario.steps[0] text]);
    XCTAssertEqualObjects(@"I run the tests", [firstScenario.steps[1] text]);
    XCTAssertEqualObjects(@"the scenarios will be run", [firstScenario.steps[2] text]);
}

/*
 Scenario: Comments are excluded
 And the feature file contains comments #like this one
 When the feature file #is parsed
 # Without this line included
 Then the comments will be ignored
 */
- (void)testCommentsAreIgnored
{
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Feature" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    XCQScenario *scenario = feature.scenarios[1];
    
    XCTAssertEqualObjects(@"Comments are excluded", scenario.title);
    XCTAssertEqual(3u, [scenario.steps count]);
    XCTAssertEqualObjects(@"the feature file contains comments", [scenario.steps[0] text]);
    XCTAssertEqualObjects(@"the feature file", [scenario.steps[1] text]);
    XCTAssertEqualObjects(@"the comments will be ignored", [scenario.steps[2] text]);
}

/*
 Scenario Outline: Scenarios outlines are parsed
 And the feature has a scenario outline
 When the outline has <options>
 Then the steps will be filled with <values>
 | options   | values    |
 | black     | white     |
 | bark      | bite      |
 | shark     | hey man   |
*/
- (void)testScenarioOutlinesAreParsedIntoMultipleScenarios
{
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Feature" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    XCQScenario *outline = feature.scenarios[2];
    
    XCTAssertEqualObjects(@"Scenario outlines are parsed", outline.title);
    XCTAssertEqualObjects(@"the feature has a scenario outline", [outline.steps[0] text]);
    XCTAssertEqualObjects(@"the outline has black", [outline.steps[1] text]);
    XCTAssertEqualObjects(@"the steps will be filled with white", [outline.steps[2] text]);
    
    outline = feature.scenarios[3];
    XCTAssertEqualObjects(@"Scenario outlines are parsed", outline.title);
    XCTAssertEqualObjects(@"the outline has bark", [outline.steps[1] text]);
    XCTAssertEqualObjects(@"the steps will be filled with bite", [outline.steps[2] text]);

    outline = feature.scenarios[4];
    XCTAssertEqualObjects(@"Scenario outlines are parsed", outline.title);
    XCTAssertEqualObjects(@"the outline has shark", [outline.steps[1] text]);
    XCTAssertEqualObjects(@"the steps will be filled with hey man", [outline.steps[2] text]);

}

- (void)testStepsAreGivenCorrectLineNumbers
{
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Feature" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    XCQScenario *firstScenario = [[feature scenarios] firstObject];
    
    XCTAssertEqualObjects(@"Scenarios are parsed", firstScenario.title);
    XCTAssertEqual([firstScenario.steps[0] lineNumber], 11u);
    
    XCQScenario *lastScenario = feature.scenarios[4];
    XCTAssertEqualObjects(@"the steps will be filled with hey man", [lastScenario.steps[2] text]);
    XCTAssertEqual([lastScenario.steps[2] lineNumber], 24u);
}

- (void)testStepsAreGivenCorrectFileNames
{
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Feature" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath directory:@"/Directory/Path"];
    
    XCQScenario *firstScenario = [[feature scenarios] firstObject];
    XCTAssertEqualObjects([firstScenario.steps[0] filePath], @"/Directory/Path/Feature.feature");

    featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Second" ofType:@"feature"];
    feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath directory:@"/Directory/Path"];
    
    firstScenario = [[feature scenarios] firstObject];
    XCTAssertEqualObjects([firstScenario.steps[0] filePath], @"/Directory/Path/Second.feature");
}

- (void)testStepsWithSpecialCharactersAreGivenCorrectSelectors
{
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Feature" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    
    XCQScenario *lastScenario = feature.scenarios[5];
    XCTAssertEqualObjects(@"the action_type is menu-tap", [lastScenario.steps[0] text]);
    XCTAssertEqualObjects(@"TheActionTypeIsMenuTap", NSStringFromSelector([lastScenario.steps[0] selector]));
}

- (void)testStepsWithSpecialCharactersAreGivenCorrectCapitalisation
{
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Second" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    
    XCQScenario *lastScenario = feature.scenarios[2];
    XCTAssertEqualObjects(@"it isn't capitalised strangely", [[lastScenario.steps lastObject] text]);
    XCTAssertEqualObjects(@"ItIsntCapitalisedStrangely", NSStringFromSelector([[lastScenario.steps lastObject] selector]));
}

- (void)testScenariosFromFeaturesWithTagsIncludeFeatureTags
{
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Third" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    XCQScenario *firstScenario = feature.scenarios[0];
    NSSet *expectedTags = [NSSet setWithObjects:@"tag1", @"tag2", @"tag3", nil];
    XCTAssertEqualObjects(expectedTags, [firstScenario tags]);
}

- (void)testScenariosWithTagsIncludeScenarioTags
{
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Third" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    XCQScenario *scenario = feature.scenarios[1];
    XCTAssertTrue([scenario.tags containsObject:@"tag4"]);

}

- (void)testScenarioAndFeatureTagsAreCumulative
{
    NSString *featureFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Third" ofType:@"feature"];
    XCQFeature *feature = [XCQFeatureParser featureWithFeatureFilePath:featureFilePath];
    XCQScenario *scenario = feature.scenarios[2];
    NSSet *expectedTags = [NSSet setWithObjects:@"tag1", @"tag2", @"tag3", @"tag5", @"tag6", nil];

    XCTAssertEqualObjects(expectedTags, [scenario tags]);

}

@end

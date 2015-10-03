//
//  XCQScenarioTestSuite.m
//  XCCuke
//
//  Created by Stuart Sharpe on 13/02/2015.
//  Copyright (c) 2015 initWithStyle. All rights reserved.
//

#import "XCQScenarioTestSuite.h"
#import "XCQFeature.h"
#import "XCQScenario.h"
#import "XCQStep.h"
#import "XCTestCase+XCQStepTestCase.h"
#import "XCQScenarioTestSuiteObserver.h"
#import "XCQStepDefinition.h"
#import <XCTest/XCTest.h>
@interface XCQScenarioTestSuite () <XCQStepTestCaseDelegate>

@property (strong) XCQScenario *scenario;
@property (strong) id<XCQScenarioTestSuiteObserver>observer;

@end

@implementation XCQScenarioTestSuite

+ (instancetype)testSuiteWithScenario:(XCQScenario *)scenario
                           background:(XCQScenario *)background
                             observer:(id<XCQScenarioTestSuiteObserver>)observer;
{
    XCQScenarioTestSuite *scenarioSuite = [XCQScenarioTestSuite testSuiteWithName:[NSString stringWithFormat:@"Scenario: %@", scenario.title]];
    scenarioSuite.scenario = scenario;
    scenarioSuite.observer = observer;
    
    for (XCQStep *step in background.steps) {
        [scenarioSuite addTest:[XCQStepDefinition testCaseWithStep:step]];
    }
    for (XCQStep *step in scenario.steps) {
        [scenarioSuite addTest:[XCQStepDefinition testCaseWithStep:step]];
    }
    if (scenarioSuite.tests.count > 0) {
        [(XCQStepDefinition *)scenarioSuite.tests[0] setDelegate:scenarioSuite];
    }
    return scenarioSuite;
}

- (void)uiTestingServerActive
{
    NSLog(@"UI test server active!");
    if ([self.observer respondsToSelector:@selector(testSuite:uiTestingServerBeganForScenario:)]) {
        [self.observer testSuite:self uiTestingServerBeganForScenario:self.scenario];
    }
}

- (void)performTest:(XCTestRun *)run
{
    [self.observer testSuite:self willBeginTestingScenario:self.scenario];
    [super performTest:run];
    [self.observer testSuite:self didFinishTestingScenario:self.scenario];
}


@end

